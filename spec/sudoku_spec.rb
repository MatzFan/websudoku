require File.expand_path '../spec_helper.rb', __FILE__

# describe "sudoku app" do

feature "the homepage" do #, :type => :feature do
  let(:easy_string) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
  let(:sudoku) { Sudoku.new easy_string }
  let(:solved_string) {'615493872348127956279568431496832517521746389783915264952681743864379125137254698'}
  let(:solved_sudoku) { Sudoku.new solved_string }
  # before :each do

  #   Sudoku.new(:email => 'user@example.com', :password => 'caplin')
  # end

  # let(:easy_string) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
  # let(:sudoku) { Sudoku.new easy_string }
  # let(:solved_string) {'615493872348127956279568431496832517521746389783915264952681743864379125137254698'}
  # let(:solved_sudoku) { Sudoku.new solved_string }

  # context '#puzzle' do
  #   it 'should return a sudoku puzzle string with 41 zeros' do
  #     puzzle(solved_sudoku.to_s.chars).count('0').should == 41
  #   end
  # end # of context

  feature 'homepage' do
    scenario 'get should set session cookies' do
      # session = {}
      visit '/'
      cookies = [:current_solution, :solution, :puzzle]
      cookies.each { |cookie| session[cookie].length.should == 81 }
    end

  end # of context
  feature '#application helpers' do
    scenario 'post should call colour_class method' do
      session = { cell: easy_string.split('') }
      post '/', { :cell => easy_string.split('') }, rack_env = { 'rack.session' => session }
    end
  end

end # of feature
