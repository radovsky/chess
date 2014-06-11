require './piece'

class SlidingPiece < Piece
  def moves
    moves_arr = []
    self.move_dirs.each do |dir|
      1.upto(7) do |i|
        destination = [@pos[0] + dir[0]*i, @pos[1] + dir[1]*i]        
        if in_bounds?(destination) && collision(destination)
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
    
    moves_arr
  end
  
end

class Bishop < SlidingPiece
  
  def move_dirs
    Piece::DIAGONALS
  end
end

class Rook < SlidingPiece
  
  def move_dirs
    Piece::STRAIGHTS
  end
end

class Queen < SlidingPiece
  
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
end