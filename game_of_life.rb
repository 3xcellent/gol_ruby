require 'terminfo'
require_relative 'cell'
require 'byebug'

class GameOfLife
  attr_reader :height, :width, :cells

  def initialize
    screen_size = TermInfo.screen_size
    @height = screen_size[0]
    @width = screen_size[1]
    create_cells
  end

  def output
    @cells.collect do |row|
      row.collect do |cell|
        cell.alive? ? '*' : ' '
      end.join
    end.join
  end

  def step
    set_next_states
    step_cells
  end

  private

  def create_cells
    @cells = Array.new(@height) { Array.new(@width) { Cell.new } }
  end

  def set_next_states
    @cells.each_with_index do |row,x|
      row.each_with_index do |cell,y|
        cell.set_next_state(number_living_neighbors(x,y))
      end
    end
  end

  def number_living_neighbors(x_coord,y_coord)
    num_alive = 0
    (x_coord-1..x_coord+1).each do |x|
      next if x < 0 || x >= @height
      (y_coord-1..y_coord+1).each do |y|
        next if y < 0 || y >= @width || (x==x_coord && y==y_coord)
        num_alive += 1 if @cells[x][y].alive?
      end
    end
    num_alive
  end

  def step_cells
    @cells.each_with_index do |row|
      row.each_with_index do |cell|
        cell.step
      end
    end
  end
end
