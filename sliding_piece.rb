require './piece'

class SlidingPiece < Piece
  def moves
    moves_arr = []
    self.move_dirs.each do |dir|
      1.upto(7) do |i|
        destination = [@pos[0] + dir[0]*i, @pos[1] + dir[1]*i] 
               
        if in_bounds?(destination) && collision?(destination)
          if @board.get_piece(destination).color != @color
            moves_arr << destination
            break
          else
            break
          end 
        elsif in_bounds?(destination)
          moves_arr << destination
        end
      end
    end    
    moves_arr - [pos[0],pos[1]]
  end
  
end

class Bishop < SlidingPiece
  def initialize(window, pos, board, color)
    super(window, pos, board, color)
    @image = Gosu::Image.new(window, "./media/white_bishop.png", true) if color == :W
    @image = Gosu::Image.new(window, "./media/black_bishop.png", true) if color == :B
  end  
  
  def move_dirs
    Piece::DIAGONALS
  end
end

class Rook < SlidingPiece
  
  def initialize(window, pos, board, color)
    super(window, pos, board, color)
    @image = Gosu::Image.new(window, "./media/white_rook.png", true) if color == :W
    @image = Gosu::Image.new(window, "./media/black_rook.png", true) if color == :B
  end
  
  def move_dirs
    Piece::STRAIGHTS
  end
end

class Queen < SlidingPiece
  
  def initialize(window, pos, board, color)
    super(window, pos, board, color)
    @image = Gosu::Image.new(window, "./media/white_queen.png", true) if color == :W
    @image = Gosu::Image.new(window, "./media/black_queen.png", true) if color == :B
  end
  
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
end