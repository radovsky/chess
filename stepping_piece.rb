require './piece'

class SteppingPiece < Piece
  
  def moves
    moves_arr = []
    self.move_dirs.each do |dir|
      destination = [@pos[0] + dir[0], @pos[1] + dir[1]] 
      
      if in_bounds?(destination) && collision?(destination)
        if @board.get_piece(destination).color != @color
          moves_arr << destination
        end
      elsif in_bounds?(destination)
        moves_arr << destination
      end
      
    end
    moves_arr - [pos[0],pos[1]]
  end  
end

class King < SteppingPiece  
  def initialize(window, pos, board, color)
    super(window, pos, board, color)
    @image = Gosu::Image.new(window, "./media/white_king.png",true) if color == :W
    @image = Gosu::Image.new(window, "./media/black_king.png",true) if color == :B
  end
  
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end  
end

class Knight < SteppingPiece  
  def initialize(window, pos, board, color)
    super(window, pos, board, color)
    @image = Gosu::Image.new(window, "./media/white_knight.png",true) if color == :W
    @image = Gosu::Image.new(window, "./media/black_knight.png",true) if color == :B
  end
  
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
  def initialize(window, pos, board, color)
    super(window, pos, board, color)
    @image = Gosu::Image.new(window, "./media/white_pawn.png",true) if color == :W
    @image = Gosu::Image.new(window, "./media/black_pawn.png",true) if color == :B
  end
  
  def moves
    moves_arr = []
    standard_move = @color == :B ? [1, 0] : [-1,0]    
    capture_moves = @color == :B ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
    
    std_move_pos = [ @pos[0]+standard_move[0], @pos[1]+standard_move[1] ]    
    capt_poses = capture_moves.map { |mov| [ @pos[0]+mov[0], @pos[1]+mov[1] ] }
    
    capt_poses.each do |mov|
      if collision?(mov) && in_bounds?(mov)
        moves_arr << mov
      end
    end      
      
    unless collision?(std_move_pos) || !in_bounds?(std_move_pos)
      moves_arr << std_move_pos
    end
   
    double_move= [(@color == :B ? 2 : -2) + @pos[0],@pos[1]]
   if is_first_move? && !collision?(double_move)
     moves_arr <<  double_move
    end
    moves_arr  
  end
  
  def is_first_move?
    if @color == :B
      @pos[0] == 1
    else
      @pos[0] == 6
    end
  end
end