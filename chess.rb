require './piece'
require './board'
require './stepping_piece'
require './sliding_piece'
require 'gosu'

class ChessGame < Gosu::Window
  
  attr_accessor :curr_player, :window
  
  def initialize
    super(600, 600, true)
    @curr_player = :W
    @board = Board.new
    @board.place_pieces(self)
    self.caption = "Super Fucking Awesome Chess"
    @background_image = Gosu::Image.new(self, "./media/600px-Chess_Board.png", true)
  end
  
  def needs_cursor?
    true
  end  
  
  def update 

  end
  
  def button_down(id)
    
    if id == Gosu::MsLeft
      puts "Storing starting pos #{get_mouse_grid}}"
      @starting_pos = get_mouse_grid
    end
   
  end
  
  def button_up(id)
    if id == Gosu::MsLeft
      @ending_pos = get_mouse_grid
      moving_piece = @board.get_piece(@starting_pos)
      
      if valid_piece(moving_piece)
        #returns true for properly executed move        
        if @board.move(@starting_pos,@ending_pos) 
          switch_player 
        else
          puts "Invalid move!"
        end          
      end
    end      
  end
  
  def valid_piece(moving_piece)
    !moving_piece.nil? && moving_piece.color == @curr_player
  end
  
  def get_mouse_grid
    mouse = []
    mouse = mouse_x, mouse_y
    [((mouse[1] - 10) / 75).to_i,((mouse[0] - 10) / 75).to_i]
  end

  def grid_to_pixel(x, y, z = 0.5)
    [(y * 75 + 10).to_i, (x * 75 + 10).to_i,z]
  end

  def draw
    @background_image.draw(0,0,0)
    @board.all_pieces.each { |piece| piece.draw unless piece == @click_hold_piece }
  end
    
  def get_turn
    @curr_player
  end
  
  def switch_player
    @curr_player = @curr_player == :W ? :B : :W
  end

  def game_complete?
    @board.checkmate?(:W) || @board.checkmate?(:B)
  end
  
  def get_user_piece(pos)
    @board.grid[pos[0]][pos[1]]
  end
  
  def get_piece_at_mouse
    mouse_pos = @window.get_mouse_grid
    @board.get_piece(mouse_pos)
  end
end

class MousePosError < StandardError
  def initialize(message)
    super(message)
  end
end