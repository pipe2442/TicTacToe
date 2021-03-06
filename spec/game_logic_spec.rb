# spec/game_logic_spec.rb
require_relative '../lib/game_logic'

# Intantiate classes

describe Board do
  let(:board) { Board.new }
  let(:clear_board) { Board.new }

  player1 = Player.new('X')
  player2 = Player.new('O')

  win1 = Board.new
  win1.change_box('1', player1)
  win1.change_box('4', player1)
  win1.change_box('7', player1)

  win2 = Board.new
  win2.change_box('1', player2)
  win2.change_box('4', player2)
  win2.change_box('7', player2)

  draw = Board.new
  draw.change_box('1', player1)
  draw.change_box('2', player1)
  draw.change_box('3', player2)
  draw.change_box('4', player2)
  draw.change_box('5', player2)
  draw.change_box('6', player1)
  draw.change_box('7', player1)
  draw.change_box('8', player2)
  draw.change_box('9', player1)

  describe '#check_input' do
    it 'returns false if input == 0' do
      expect(board.check_input(0)).to be false
    end
    it 'returns false if input is negative' do
      expect(board.check_input(-2)).to be false
    end
    it 'returns false if input is more than 10' do
      expect(board.check_input(12)).to be false
    end
    it 'returns true if input is 0 < input < 10' do
      expect(board.check_input(5)).to be true
    end
  end

  describe '#check_board' do
    it 'Return true if box was not previously chosen' do
      expect(clear_board.check_board('1')).to be true
    end
    it 'Return false if box was not previously chosen' do
      expect(win1.check_board('1')).to be false
    end
    it 'Return false if box was not previously chosen' do
      expect(win2.check_board('7')).to be false
    end
    it 'Return false if box was not previously chosen' do
      expect(draw.check_board('9')).to be false
    end
  end

  describe '#change_box' do
    it 'Change the box number into a player 1 tag' do
      expect(win1.change_box('5', player1)).to be win1.board_grid[4]
    end

    it 'Change the box number into a player 2 tag' do
      expect(win2.change_box('9', player2)).to be win2.board_grid[8]
    end
  end

  describe '#check_winner' do
    it 'Return the player Object if winner is found' do
      expect(win1.check_winner(player1)).to be player1
    end
    it 'Return the player Object if winner is found' do
      expect(win2.check_winner(player2)).to be player2
    end
    it 'Return nil if no winner' do
      expect(draw.check_winner(player2)).to be nil
    end
  end

  describe '#check_draw' do
    it 'Return true if board has no numbers and winner is nil' do
      expect(draw.check_draw(nil)).to be true
    end
    it 'Return nil if trying to pass a player object as winner on a draw board' do
      expect(draw.check_draw(player1)).to be nil
    end
  end
end
