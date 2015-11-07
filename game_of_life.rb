require 'terminfo'
require_relative 'cell'
require 'byebug'
require 'curses'


class GameOfLife
  include Curses

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

  def cycle_cells
    @cells = CycleHandler.new(@cells, @height, @width).cycle_cells
  end

  def setup
    Curses.init_screen
    Curses.start_color

    Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK)
    Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)
    Curses.init_pair(COLOR_GREEN,COLOR_GREEN,COLOR_BLACK)

    init_cells
  end

  def random_state
    [Cell::ALIVE, Cell::DEAD].sample
  end

  def run(steps = 1000)
    steps.times do
      run_cycle
    end
  end

  def run_cycle
    update_screen
    cycle_cells
    sleep 0.01
  end

  private

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

  def update_screen
    for_each_cell do |cell, x, y|
      Curses.setpos(x, y)
      print_cell(cell)
    end
    Curses.refresh
  end

  def print_cell(cell)
    char = cell.alive? ? '*' : ' '

    if cell.previous_state == cell.alive?
      color = COLOR_BLUE
    elsif cell.alive?
      color = COLOR_GREEN
    else
      color = COLOR_RED
      char = '*'
    end

    Curses.attron(color_pair(color)|A_NORMAL) do
      Curses.addstr(char)
    end
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

end

class CycleHandler

  def initialize(cells, height, width)
    @cells = cells
    @height = height
    @width = width
  end

  def cycle_cells
    set_next_states
    step_cells
    @cells
  end

  private

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
