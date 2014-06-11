require './piece'
require './board'
require './stepping_piece'
require './sliding_piece'

class Chess
  def initialize
    @board = Board.new
    @curr_player = :W
  end
  
  def play
    until game_complete?
      display
      play_turn(@curr_player)
      switch_player
    end
    end_game
  end
  
  def display
    @board.grid.each do |row|
      row.each do |tile|
        get_unicode
    end
  end
  
  def get_unicode(tile)
    if tile.color == :W 
      
      case tile
      when nil
      
  end
  
  def end_game
    if @board.checkmate?(:W)
      puts "Black player wins!"
    else
      puts "White player wins!"
    end
  end
  
  def switch_player
    @curr_player = (@curr_player == :W ? :B : :W)
  end

  def game_complete?
    @board.checkmate?(:W) || @board.checkmate?(:B)
  end
  
  def get_user_input
    
    store = gets.chomp.split(",")
    [Integer(store[0]),Integer(store[-1])]
  end
  
  def get_user_piece(pos)
    @board.grid[pos[0]][pos[1]]
  end
  
  def play_turn(color)
    begin 
      puts "Input your move coordinates separated by comma"
      "U+2654"
      piece_to_move = get_user_piece(get_user_input)
      if piece_to_move.nil? || piece_to_move.color != color
        raise InvalidMoveError, "This is not one of your pieces!"
      end 
      puts "Input your move coordinates destination"
      dest = get_user_input
      @board.move(piece_to_move.pos, dest)      
      
    rescue InvalidMoveError => e
      puts e.message
      retry
    end
  end
  
end