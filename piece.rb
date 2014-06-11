

class Piece
  attr_accessor :color, :pos
  
  STRAIGHTS = [ [1, 0], [0, 1], [-1, 0], [0, -1] ]
  DIAGONALS =  [ [-1, 1], [1, 1], [-1, -1], [1, -1] ]
  def initialize(pos, board, color)
    @pos = pos  
    @board = board
    @color = color
  end
  
  def to_s
    name = self.class.to_s[0] unless self.class == Knight
    name = "N" if self.class == Knight
    "#{name}_#{@color.to_s}"
  end
  
  def in_bounds?(pos)
    (0..7).include?(pos[0]) && (0..7).include?(pos[1])
  end
  
  
  def valid_moves
    possible_moves = self.moves
    possible_moves.select {|move| !move_into_check?(move)}
  end
  
  def collision(sq)
    !@board.get_piece(sq).nil?
  end
  
  def move_into_check?(new_pos)
    new_board = @board.dup
    new_piece = new_board.grid[@pos[0]][@pos[1]]
    
    return false if new_piece.nil?
    new_board.move!(@pos, new_pos)
    new_board.in_check?(new_piece.color)
  end
  
  
  def dup(new_board)
    self.class.new(@pos.dup, new_board, @color)    
  end
  
end

