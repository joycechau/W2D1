require_relative 'cursor'
require_relative 'board'
require 'colorize'
require 'byebug'

class Display
  attr_reader :cursor
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def move_piece(start_pos, end_pos)
    raise "Nothing there!" if @board[start_pos].nil?
    raise "Illegal move!" unless @board[end_pos].nil?
    @board[start_pos], @board[end_pos] = @board[end_pos], @board[start_pos]
  end

  def test_cursor   #Will become play
    100.times do
      @cursor.get_input
      system "clear"
      render
    end
  end

  def render
    print "    0 | 1 | 2 | 3 | 4 | 5 | 6 | 7"
    @board.grid.each_with_index do |row, index|
      # debugger 
      print "\n"
      puts "-----------------------------------"
      print "#{index} |"

      row.each_with_index do |space, index2|
        if !space.is_a?(NullPiece)
          print " #{space.name} |" unless @cursor.cursor_pos == [index, index2]
          print " #{space.name} ".red + '|' if @cursor.cursor_pos == [index, index2]
        else
          print '   |' unless @cursor.cursor_pos == [index, index2]
          print ' √ '.red + '|' if @cursor.cursor_pos == [index, index2]
        end
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render
  display.test_cursor
end
