# spec/spec_helper.rb
ENV['RACK_ENV'] = 'test'


require 'rack/test'

require File.expand_path '../../sudoku.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }
