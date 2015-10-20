require 'terminfo'

class GameOfLife
  attr_reader :height, :width

  def initialize
    screen_size = TermInfo.screen_size
    @height = screen_size[0]
    @width = screen_size[1]
  end
end
