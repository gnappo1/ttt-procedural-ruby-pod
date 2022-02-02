require_relative '../lib/ttt.rb'


describe '#input_to_index' do

    it 'converts a user_input to an integer' do
      user_input = "1"
      converted_input = input_to_index(user_input)
      
      expect(converted_input).to be_a(Integer)
    end
  
    it 'subtracts 1 from the user_input' do
      user_input = "6"
      converted_input = input_to_index(user_input)
  
      expect(converted_input).to be(5)
    end
  
    it 'returns -1 for strings without integers' do
      user_input = "invalid"
      converted_input = input_to_index(user_input)
      
      expect(converted_input).to be(-1)
    end
  
end
describe '#move' do
    it 'defines a move method' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      expect(defined?(move)).to be_truthy
    end
  
    context '#move' do
      it 'accepts 3 arguments: the board, the position a player wants to fill and their char, X or O' do
        expect{move}.to raise_error(ArgumentError)
      end
  
      it 'provides a default value for the 3rd argument' do
        board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        expect {move(board, 2)}.to_not raise_error
      end
  
      it 'allows "X" player in the top left position' do
        board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        move(board, 0, "X")
  
        expect(board).to eq(["X", " ", " ", " ", " ", " ", " ", " ", " "])
      end
  
      it 'allows "O" player in the middle' do
        board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        move(board, 4, "O")
  
        expect(board).to eq([" ", " ", " ", " ", "O", " ", " ", " ", " "])
      end
  
      it 'allows "X" player in the bottom right' do
        board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        move(board, 8)
  
        expect(board).to eq([" ", " ", " ", " ", " ", " ", " ", " ", "X"])
      end
  
      it 'allows "X" player in the bottom right and "O" in the top left ' do
        board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        move(board, 0, "O")
        move(board, 8, "X")
  
        expect(board).to eq(["O", " ", " ", " ", " ", " ", " ", " ", "X"])
      end
  
      it 'allows "X" to win diagonally' do
        board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        move(board, 0)
        move(board, 4)
        move(board, 8)
  
        expect(board).to eq(["X", " ", " ", " ", "X", " ", " ", " ", "X"])
      end
  
      it 'allows a tie game' do
        board = Array.new(9, " ")
        move(board, 0, "X")
        move(board, 1, "O")
        move(board, 2, "X")
        move(board, 3, "O")
        move(board, 4, "X")
        move(board, 5, "O")
        move(board, 6, "X")
        move(board, 7, "X")
        move(board, 8, "O")      
  
        expect(board).to eq(["X", "O", "X", "O", "X", "O", "X", "X", "O"])
      end
    end
end
describe '#valid_move' do
    it 'returns true for a valid position on an empty board' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      index = 0
      expect(valid_move?(board, index)).to be_truthy
    end
  
    it 'returns true for a valid position on a non-empty board' do
      board = [" ", " ", "X", " ", " ", " ", " ", "O", " "]
      index = 5
      expect(valid_move?(board, index)).to be_truthy
    end
  
    it 'returns nil or false for an occupied position' do
      board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
      index = 4
  
      expect(valid_move?(board, index)).to be_falsey
    end
  
    it 'returns nil or false for a position that is not on the board' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      index = 100
  
      expect(valid_move?(board, index)).to be_falsey
    end
end
describe '#turn' do
    it 'asks the user for input by printing: "Please enter 1-9:"' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)
      allow(self).to receive(:gets).and_return("1")

      expect($stdout).to receive(:puts).with("Please enter 1-9:")

      turn(board)
    end

    it 'gets the user input' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      expect(self).to receive(:gets).and_return("1")

      turn(board)
    end

    it 'calls the input_to_index method' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      allow(self).to receive(:gets).and_return("1")

      expect(self).to receive(:input_to_index).and_call_original

      turn(board)
    end

    it 'validates the input correctly' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      expect(self).to receive(:gets).and_return("1")
      expect(self).to receive(:valid_move?).with(board, 0).and_return(true)

      turn(board)
    end

    it 'asks for input again after a failed validation' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

      allow($stdout).to receive(:puts)

      expect(self).to receive(:gets).and_return("invalid")
      expect(self).to receive(:gets).and_return("1")

      turn(board)
    end

    it 'makes valid moves' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

      allow($stdout).to receive(:puts)

      expect(self).to receive(:gets).and_return("1")

      turn(board)

      expect(board).to match_array(["X", " ", " ", " ", " ", " ", " ", " ", " "])
    end

    # it 'displays a correct board after a valid turn' do
    #   board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

    #   allow(self).to receive(:gets).and_return("5")

    #   output = capture_puts{ turn(board) }

    #   expect(turn(board).to include("   |   |   ")
    #   expect(turn(board).to include("-----------")
    #   expect(turn(board).to include("   | X |   ")
    #   expect(turn(board).to include("-----------")
    #   expect(turn(board).to include("   |   |   ")
    # end
end
describe "game_status" do
    describe 'WIN_COMBINATIONS' do
      it 'defines a constant WIN_COMBINATIONS with arrays for each win combination' do
        expect(WIN_COMBINATIONS.size).to eq(8)
  
        expect(WIN_COMBINATIONS).to include([0,1,2])
        expect(WIN_COMBINATIONS).to include([3,4,5])
        expect(WIN_COMBINATIONS).to include([6,7,8])
        expect(WIN_COMBINATIONS).to include([0,3,6])
        expect(WIN_COMBINATIONS).to include([1,4,7])
        expect(WIN_COMBINATIONS).to include([2,5,8])
        expect(WIN_COMBINATIONS).to include([0,4,8])
        expect(WIN_COMBINATIONS).to include([6,4,2])
      end
    end
  
    describe "#won?" do
      it 'returns falsey for an empty board' do
        board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  
        expect(won?(board)).to be_falsey
      end
  
      it 'returns falsey for a draw' do
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
  
        expect(won?(board)).to be_falsey
      end
  
      it 'returns an array of matching indexes for a top row win' do
        board = ["X", "X", "X", "O", "O", " ", " ", " ", " "]
  
        expect(won?(board)).to match_array([0,1,2])
      end
  
      it 'returns an array of matching indexes for a middle row win' do
        board = ["O", "O", " ", "X", "X", "X", " ", " ", " "]
  
        expect(won?(board)).to match_array([3,4,5])
      end
  
      it 'returns an array of matching indexes for a bottom row win' do
        board = [" ", " ", " ", "O", "O", " ", "X", "X", "X"]
  
        expect(won?(board)).to match_array([6,7,8])
      end
  
      it 'returns an array of matching indexes for a left column win' do
        board = ["O", " ", "X", "O", " ", "X", "O", " ", " "]
  
        expect(won?(board)).to match_array([0,3,6])
      end
  
      it 'returns an array of matching indexes for a middle column win' do
        board = ["X", "O", " ", "X", "O", " ", " ", "O", " "]
  
        expect(won?(board)).to match_array([1,4,7])
      end
  
      it 'returns an array of matching indexes for a right column win' do
        board = ["X", " ", "O", "X", " ", "O", " ", " ", "O"]
  
        expect(won?(board)).to match_array([2,5,8])
      end
  
      it 'returns an array of matching indexes for a left diagonal win' do
        board = ["X", " ", "O", " ", "X", "O", " ", " ", "X"]
  
        expect(won?(board)).to match_array([0,4,8])
      end
  
      it 'returns an array of matching indexes for a right diagonal win' do
        board = ["X", " ", "O", "X", "O", " ", "O", " ", " "]
  
        expect(won?(board)).to match_array([2,4,6])
      end
    end
  
    describe '#full?' do
      it 'returns true for a draw' do
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
  
        expect(full?(board)).to be_truthy
      end
  
      it 'returns false for an in-progress game' do
        board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
  
        expect(full?(board)).to be_falsey
      end
    end
  
    describe '#draw?' do
      it 'returns true for a draw' do
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
  
        expect(draw?(board)).to be_truthy
      end
  
      it 'returns false for a game won in the first row' do
        board = ["X", "X", "X", "O", "X", "O", "O", "O", "X"]
  
        expect(draw?(board)).to be_falsey
      end
  
      it 'returns false for a won game diagonaly' do
        board = ["X", "O", "X", "O", "X", "O", "O", "O", "X"]
  
        expect(draw?(board)).to be_falsey
      end
  
      it 'returns false for an in-progress game' do
        board = ["X", " ", "X", " ", "X", " ", "O", "O", "X"]
  
        expect(draw?(board)).to be_falsey
      end
    end
  
    describe '#over?' do
      it 'returns true for a draw' do
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
  
        expect(over?(board)).to be_truthy
      end
  
      it 'returns true for a won game when the board is full' do
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
  
        expect(over?(board)).to be_truthy
      end
  
      it 'returns true for a won game when the board is not full' do
        board = ["X", " ", " ", "O", "O", "O", "X", "X", " "]
  
        expect(over?(board)).to be_truthy
      end
  
      it 'returns false for an in-progress game' do
        board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
  
        expect(over?(board)).to be_falsey
      end
    end
  
    describe '#winner' do
      it 'return X when X won' do
        board = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
  
        expect(winner(board)).to eq("X")
      end
  
      it 'returns O when O won' do
        board = ["X", "O", " ", " ", "O", " ", " ", "O", "X"]
  
        expect(winner(board)).to eq("O")
      end
  
      it 'returns nil when no winner' do
        board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
  
        expect(winner(board)).to be_nil
      end
    end
end
describe '#valid_move' do
    it 'returns true for a valid position on an empty board' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      index = 0
      expect(valid_move?(board, index)).to be_truthy
    end
  
    it 'returns true for a valid position on a non-empty board' do
      board = [" ", " ", "X", " ", " ", " ", " ", "O", " "]
      index = 5
      expect(valid_move?(board, index)).to be_truthy
    end
  
    it 'returns nil or false for an occupied position' do
      board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
      index = 4
  
      expect(valid_move?(board, index)).to be_falsey
    end
  
    it 'returns nil or false for a position that is not on the board' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      index = 100
  
      expect(valid_move?(board, index)).to be_falsey
    end
end
describe '#play' do
    it 'calls turn nine times' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  
      allow(self).to receive(:gets).and_return('1','2','3','4','5','6','7','8','9')
      
      play(board)
  
      expect(board).to eq(["X","X","X","X","X","X","X","X","X",])
    end
  end
describe "#current_player" do
  describe '#turn_count' do
    it 'counts occupied positions' do
      board1 = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
      board2 = ["O", " ", " ", " ", "X", " ", " ", "O", "X"]

      expect(turn_count(board1)).to eq(3)
      expect(turn_count(board2)).to eq(4)
    end
  end

  describe '#current_player' do
    it 'returns the correct player, X, for the first move' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

      expect(current_player(board)).to eq("X")
    end

    it 'returns the correct player, O, for the second move' do
      board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]

      expect(current_player(board)).to eq("O")
    end

    it 'returns the correct player, X, for the third move' do
      board = ["O", " ", " ", " ", "X", " ", " ", " ", " "]

      expect(current_player(board)).to eq("X")
    end
  end  
end