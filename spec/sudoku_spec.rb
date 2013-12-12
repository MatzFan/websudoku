require File.expand_path '../spec_helper.rb', __FILE__

describe "sudoku app" do

  let(:sudoku) { Sudoku.new '015003002000100906270068430490002017501040380003'+
                            '905000900081040860070025037204600' }
  let(:solved_sudoku) { Sudoku.new '61549387234812795627956843149683251752174'+
                            '6389783915264952681743864379125137254698' }

  context '#puzzle' do
    it 'should return a sudoku puzzle with 41 zeros' do
      puzzle(solved_sudoku).class.should == Sudoku
    end


  end # of context

end # of describe
