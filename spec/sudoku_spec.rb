require File.expand_path '../spec_helper.rb', __FILE__

describe "sudoku app" do


  let(:easy_string) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
  let(:sudoku) { Sudoku.new easy_string }
  let(:solved_string) {'615493872348127956279568431496832517521746389783915264952681743864379125137254698'}
  let(:solved_sudoku) { Sudoku.new solved_string }

  context '#puzzle' do
    it 'should return a sudoku puzzle string with 41 zeros' do
      puzzle(solved_sudoku.to_s.chars).count('0').should == 41
    end
  end # of context

  context '/' do
    it 'get should set session cookies' do
      session = {}
      get '/', params = {}, rack_env = { 'rack.session' => session }
      cookies = [:current_solution, :solution, :puzzle]
      cookies.each { |cookie| session[cookie].length.should == 81 }
    end

  end # of context
  context '#application helpers' do
    xit 'should set session cookies' do
      session = {}
      get '/', params = {}, rack_env = { 'rack.session' => session }
       #current_solution returns box-mapped string, prior to translation
      session[:current_solution].should == "015000270003100068002906430490501003002040905017380000900860037081070204040025600"
    end

    it 'post should call colour_class method' do
      app::Helpers.should_receive(:bollocks)
      session = { cell: easy_string.split('') }
      post '/', { :cell => easy_string.split('') }, rack_env = { 'rack.session' => session }
    end
  end

end # of describe
