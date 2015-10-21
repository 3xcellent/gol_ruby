require 'terminfo'
require_relative 'cell'

class GameOfLife
  attr_reader :height, :width, :cells

  def initialize
    screen_size = TermInfo.screen_size
    @height = screen_size[0]
    @width = screen_size[1]
    create_cells
  end

  private

  def create_cells
    @cells = Array.new(@height) { Array.new(@width) }
  end
end
