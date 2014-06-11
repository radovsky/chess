require './piece'

class SteppingPiece < Piece
  
  def moves
    #get input from move_dirs
    moves_arr = []
    self.move_dirs.each do |dir|
      destination = [@pos[0] + dir[0], @pos[1] + dir[1]] 
      if in_bounds?(destination) && collision(destination)
        if @board.get_piece(destination).color != @color
          moves_arr << destination
        end
      elsif in_bounds?(destination)
        moves_arr << destination
      end
    end
    moves_arr
  end
  
end



class King < SteppingPiece
  
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
  
end

class Knight < SteppingPiece
  def move_dirs
    [ 
      [1, 2], 
      [2, 1], 
      [-1, 2], 
      [-2, 1], 
      [1, -2], 
      [2, -1], 
      [-1, -2], 
      [-2, -1] 
    ]
  end
end

class Pawn < Piece
  def moves
    #get input from move_dirs
    moves_arr = []
    self.move_dirs.each do |dir|
      destination = [@pos[0] + dir[0], @pos[1] + dir[1]]
      if in_bounds?(destination) && collision(destination)
        if @board.get_piece(destination).color != @color
          moves_arr << destination
        end
      elsif in_bounds?(destination)
        moves_arr << destination
      end
    end
    moves_arr
  end
  
  def move_dirs  
    if @color == :B
      [[1,0]]
    else
      [[-1,0]]
    end
  end
    
end