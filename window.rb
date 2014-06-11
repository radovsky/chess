require 'gosu'

class Piece
  attr_accessor :x, :y
  def initialize(window,x,y,z)
    @image = Gosu::Image.new(window, "./white_pawn.png",true)
    @x,@y = x,y  
    puts "#{x} #{y}" 
    @p = nil   
  end
  
  def draw
    @image.draw(@x,@y,1)
    #puts "#{x},#{y}"
  end
  
  def get_grid_coord
    @window.get_mouse_grid(@x,@y)
  end
  # def move_drawing(x,y)
  #   return grid_to_pixel(x,y)
  # end
end


class GameWindow < Gosu::Window
  def initialize
    super( 600, 600, true)
    self.caption = "Gosu Tutorial Game"
    @p = Piece.new(self,*grid_to_pixel(4,4))
    @background_image = Gosu::Image.new(self, "./600px-Chess_Board.png", true)
    @white_pawns = Array.new(8) {Gosu::Image.new(self, "./white_pawn.png",true)}
    @black_pawns = Array.new(8) {Gosu::Image.new(self, "./black_pawn.png",true)}
    @black_rooks = Array.new(2) {Gosu::Image.new(self, "./black_rook.png",true)}
    @white_rooks = Array.new(2) {Gosu::Image.new(self, "./white_rook.png",true)}
    @white_bishops = Array.new(2) {Gosu::Image.new(self, "./white_bishop.png",true)}
    @black_bishops = Array.new(2) {Gosu::Image.new(self, "./black_bishop.png",true)}
    @white_knights = Array.new(2) {Gosu::Image.new(self, "./white_knight.png",true)}
    @black_knights = Array.new(2) {Gosu::Image.new(self, "./black_knight.png",true)}
    @white_queen = Gosu::Image.new(self, "./white_queen.png",true)
    @black_queen = Gosu::Image.new(self, "./black_queen.png",true)
    @white_king = Gosu::Image.new(self, "./white_king.png",true)
    @black_king = Gosu::Image.new(self, "./black_king.png",true)
    
  end

  def needs_cursor?
    true
  end

  def update
    #puts "Updating #{@p.x}"
    #@p.x = grid_to_pixel(6,0,0)[0]
    button_up(Gosu::MsLeft)
    x,y =get_mouse_grid
    puts "#{x}, #{y}"
    if button_down?(Gosu::MsLeft) && get_mouse_grid == [x,y]
      @p.x, @p.y = grid_to_pixel(*get_mouse_grid)
     end
  end

  # def button_up(id)
  #   #snaps to grid loc
  #   @p.x, @p.y = grid_to_pixel(*get_mouse_grid)
  #   return true
  # end
  
  def get_mouse_grid
    mouse = []
    mouse = mouse_x, mouse_y
    #p "#{mouse}"
    [((mouse[0]-10)/75).to_i,((mouse[1]-10)/75).to_i]
  end

  #takes in array, and returns pixel values for chess pieces
  def grid_to_pixel(x,y,z = 0.5)
    [(x*75+10).to_i, (y*75+10).to_i,z]
  end

  def draw
    gridx, gridy = get_mouse_grid
    #puts "#{gridx}, #{gridy}"
    @p.draw
    
    b = Gosu::Color.argb(0x00000000)
    @background_image.draw(0,0,0)
    
    @black_rooks[0].draw(*grid_to_pixel(0,7))
    @black_rooks[1].draw(*grid_to_pixel(7,7))
    
    @white_rooks[0].draw(*grid_to_pixel(0,0))
    @white_rooks[1].draw(*grid_to_pixel(7,0))
    
    @white_knights[0].draw(*grid_to_pixel(1,0))
    @white_knights[1].draw(*grid_to_pixel(6,0))
    
    @black_knights[0].draw(*grid_to_pixel(1,7))
    @black_knights[1].draw(*grid_to_pixel(6,7))
    
    @white_bishops[0].draw(*grid_to_pixel(2,0))
    @white_bishops[1].draw(*grid_to_pixel(5,0))
    
    @black_bishops[0].draw(*grid_to_pixel(2,7))
    @black_bishops[1].draw(*grid_to_pixel(5,7))
    
    @white_queen.draw(*grid_to_pixel(3,0))
    @black_queen.draw(*grid_to_pixel(3,7))
    
    @white_king.draw(*grid_to_pixel(4,0))
    @black_king.draw(*grid_to_pixel(4,7))    
    
    @white_pawns.each_with_index do |pawn,idx|
      pawn.draw(*grid_to_pixel(idx,1))
    end
      
    @black_pawns.each_with_index do |pawn,idx|
      pawn.draw(*grid_to_pixel(idx,6))
    end 
  end
end

window = GameWindow.new
window.show