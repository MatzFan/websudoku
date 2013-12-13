require File.expand_path '../spec_helper.rb', __FILE__

describe "sudoku app" do

  let(:sudoku) { Sudoku.new '015003002000100906270068430490002017501040380003'+
                            '905000900081040860070025037204600' }
  let(:solved_sudoku) { Sudoku.new '61549387234812795627956843149683251752174'+
                            '6389783915264952681743864379125137254698' }

  context '#puzzle' do
    it 'should return a sudoku puzzle string with 41 zeros' do
      puzzle(solved_sudoku.to_s.chars).count('0').should == 41
    end
  end # of context

  context '/' do
    it 'get should set session cookies' do
      session = {}
      get '/', {}, { 'rack.session' => session }
      cookies = [:current_solution, :solution, :puzzle]
      cookies.each { |cookie| session[cookie].length.should == 81 }
    end

    xit 'post should set session cookies' do
      session = {}
      post '/', {}, { 'rack.session' => session }
    end

  end # of context
  context '#application helpers' do
    it 'post should set session cookies' do
      should_receive(:colour_class)
      session = { cell: '015003002000100906270068430490002017501040380003905000900081040860070025037204600'.split('') }
      post '/', { :cell => '015003002000100906270068430490002017501040380003905000900081040860070025037204600'.split('')}, { 'rack.session' => session }
      session[:current_solution].should == "015000270003100068002906430490501003002040905017380000900860037081070204040025600"
    end
  end

end # of describe
