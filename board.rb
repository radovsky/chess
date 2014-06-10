load './piece.rb'


class Board
  attr_accessor :grid
  
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    starting_position
  end
  
  def starting_position
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
  
end