#!/usr/bin/env ruby

require_relative './lib/sudoku'
require_relative './lib/cell'
require './helpers/application'
require 'sinatra'
require 'sinatra/partial'
  set :partial_template_engine, :erb
require 'rack-flash'
  use Rack::Flash

configure :production do
  require 'newrelic_rpm'
end

set :session_secret, "I'm the secret key to sign the cookie"

enable :sessions unless test?

include Helpers # in /helper/application

def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars # array of 81 characters
end

def prepare_to_check_solution
  @check_solution = session[:check_solution]
  if @check_solution
    # flash notification
    flash[:notice] = "Incorrect values are highlighted in yellow"
  end
  session[:check_solution] = nil
end

def generate_new_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = puzzle(sudoku)
  session[:current_solution] = session[:puzzle]
end

def puzzle(sudoku) # to remove cells
  new_puzzle = sudoku.dup
  (0..80).to_a.sample(41).each { |i| new_puzzle[i] = '0' }
  new_puzzle.join
end

def box_order_to_row_order(cells)
  box_indicies = ([0,3,6,27,30,33,54,57,60].map{ |i| [i, i+1, i+2, i+9, i+10, i+11,i+18, i+19, i+20]}).flatten
  box_indicies.map{|box_index| cells[box_index]}
end

get '/' do
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution] || session[:puzzle]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  erb :index
end

post '/' do
  cells = params["cell"] # returns array of cells
  cells = box_order_to_row_order(cells)
  session[:current_solution] = cells.map { |value| value.to_i }.join
  session[:check_solution] = true
  redirect to('/')
end

get '/solution' do
  @current_solution = session[:solution]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  erb :index
end
