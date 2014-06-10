class Piece
  def initialize(pos, board, color)
    @moves = []
    @pos = pos  
    @board = board
    @color = color
    @captured = false
    @piece_name = "P"
  end

      # generates potential moves
  def moves

  end
  
  def to_s
    "#{@piece_name}_#{@color.to_s}"
  end
  
end

class SlidingPiece < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
  end
  
 
  
  def move
    #get input from move_dirs
    moves_arr = []
    self.move_dirs.each do |dir|
      @board.length.times do |i|
        if in_bounds([@pos[0] + dir[0]*i, @pos[1] + dir[1]*i])
          moves_arr << [@pos[0] + dir[0]*i, @pos[1] + dir[1]*i] 
        end
    end
    
  end
  
  def in_bounds(pos)
    (0..7).include?(pos[0]) && (0..7).include?(pos[1])
  end

end

class Bishop < SlidingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @piece_name = "B"
  end
  def move_dirs
    [ [-1, 1], [1, 1], [-1, -1], [1, -1] ]
  end
end

class Rook < SlidingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @piece_name = "R"
  end
  def move_dirs
    [ [1, 0], [0, 1], [-1, 0], [0, -1] ]
  end
end

class Queen < SlidingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @piece_name = "Q"
  end
  def move_dirs
    [ [-1, 1], [1, 1], [-1, -1], [1, -1], [1, 0], [0, 1], [-1, 0], [0, -1] ]
  end
end

class SteppingPiece < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class King < SteppingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @piece_name = "K"
  end
end

class Knight < SteppingPiece
  def initialize(pos, board, color)
    super(pos, board, color)
    @piece_name = "N"
  end
end

class Pawn < Piece
  def initialize(pos, board, color)
    super(pos, board, color)
    @piece_name = "P"
  end
end