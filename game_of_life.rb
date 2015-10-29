require 'terminfo'
require_relative 'cell'
require 'byebug'
require 'curses'

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
    print_output
    cycle_cells
    sleep 0.05
  end

  def setup
    Curses.init_screen
    init_cells
  end

  def random_state
    [Cell::ALIVE, Cell::DEAD].sample
  end

  def run(steps = 1000)
    steps.times do
      step
    end
  end

  private

  def cycle_cells
    set_next_states
    step_cells
  end

  def print_output
    Curses.setpos(0, 0)
    Curses.addstr(output)
    Curses.refresh
  end

  def init_cells
    @cells.each_with_index do |row|
      row.each_with_index do |cell|
        cell.set_state(random_state)
      end
    end
  end

  def create_cells
    @cells = Array.new(@height) { Array.new(@width) { Cell.new } }
  end

  def set_next_states
    for_each_cell do |cell, x, y|
      cell.set_next_state(number_living_neighbors(x, y))
    end
  end

  def number_living_neighbors(cell_x, cell_y)
    num_alive = 0
    ((cell_x - 1)..(cell_x+1)).each do |x|
      next if x < 0 || x >= @height
      (cell_y-1..cell_y+1).each do |y|
        next if y < 0 || y >= @width || (x==cell_x && y==cell_y)
        num_alive += 1 if @cells[x][y].alive?
      end
    end
    num_alive
  end

  def step_cells
    for_each_cell do |cell|
      cell.step
    end
  end

  def for_each_cell(&block)
    @cells.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        case block.arity
        when 0
          yield
        when 1
          yield cell
        when 3
          yield cell, x, y
        end
      end
    end
  end
end
