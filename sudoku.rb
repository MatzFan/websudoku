#!/usr/bin/env ruby

require 'sinatra'
require_relative './lib/sudoku'
require_relative './lib/cell'

enable :sessions

def random_sudoku
  # we're using 9 numbers, 1 to 9, and 72 zeros as an input
  # it's obvious there may be no clashes as all numbers are unique
  seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
  sudoku = Sudoku.new(seed.join)
  # then we solve this (really hard!) sudoku
  sudoku.solve!
  # and give the output to the view as an array of chars
  sudoku.to_s.chars
end

def puzzle(sudoku) # to remove cells
  new_puzzle = sudoku.dup
  until new_puzzle.count("0") == 41
    new_puzzle[(0..80).to_a.sample] = "0"
  end
  new_puzzle
end

get '/' do
  sudoku = random_sudoku
  session[:solution] = sudoku # assigns the solution to a session with hash key :solution
  @current_solution = puzzle(sudoku)
  erb :index
end

get '/solution' do
  @current_solution = session[:solution]
  erb :index
end
