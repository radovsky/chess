

class Board
  attr_accessor :grid
  
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    place_pieces
  end
  
  def place_pieces
    @grid.size.times do |idx|
      @grid[6][idx] = Pawn.new([6, idx], self, :W)
    end
    
    @grid[7][0] = Rook.new([7, 0], self, :W)
    @grid[7][7] = Rook.new([7, 7], self, :W)
    
    @grid[7][1] = Knight.new([7, 1], self, :W)
    @grid[7][6] = Knight.new([7, 6], self, :W)
    
    @grid[7][2] = Bishop.new([7, 2], self, :W)
    @grid[7][5] = Bishop.new([7, 5], self, :W)
    
    @grid[7][3] = Queen.new([7, 3], self, :W)
    @grid[7][4] = King.new([7, 4], self, :W)
    
    @grid.size.times do |idx|
      @grid[1][idx] = Pawn.new([1, idx], self, :B)
    end
    
    @grid[0][0] = Rook.new([0, 0], self, :B)
    @grid[0][7] = Rook.new([0, 7], self, :B)
    
    @grid[0][1] = Knight.new([0, 1], self, :B)
    @grid[0][6] = Knight.new([0, 6], self, :B)
    
    @grid[0][2] = Bishop.new([0, 2], self, :B)
    @grid[0][5] = Bishop.new([0, 5], self, :B)
    
    @grid[0][3] = Queen.new([0, 3], self, :B)
    @grid[0][4] = King.new([0, 4], self, :B)
  end
  
  def get_king(color)
    self.get_color(color).find{ |piece| piece.is_a?(King) }
  end
  
  def get_color(color)
    @grid.flatten.compact.select do |piece| 
      piece.color == color
    end 
  end
  
  def in_check?(color)
    if color == :B
      get_color(:W).each do |piece|
        return true if piece.moves.include?(get_king(:B).pos)
      end
    else
      get_color(:B).each do |piece|
        return true if piece.moves.include?(get_king(:W).pos)
      end
    end
    false
  end
  

  
  def move(start,end_pos)
    starting = @grid[start[0]][start[1]]
    if starting.valid_moves.include?(end_pos)
      move!(start,end_pos)
    else
      raise InvalidMoveError, "Not a valid move!"
    end
  end
  
  def move!(start, end_pos)
    starting = @grid[start[0]][start[1]]
    ending = @grid[end_pos[0]][end_pos[1]]
    ending = starting
    @grid[end_pos[0]][end_pos[1]] = starting
    @grid[start[0]][start[1]] = nil
    ending.pos = end_pos

  end
  
  
  def dup
    new_board = Board.new
    new_board.grid = Array.new(8) { Array.new(8) { nil } }
    self.grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        next if square.nil?
        new_board.grid[i][j] = square.class.new([i,j],new_board, square.color)
      end
    end
    new_board
  end
  
  #takes in a set of coordinates [0, 0] and outputs object or nil
  def get_piece(pos)
    @grid[pos[0]][pos[1]]
  end
  
  def checkmate?(color)
    if in_check?(color)
      return get_color(color).all? { |piece| piece.valid_moves.empty? }
    else
      false
    end
  end
  
end

class InvalidMoveError < StandardError
  def initialize(message)
    super(message)
  end
end












