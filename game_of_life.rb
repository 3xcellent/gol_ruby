require 'terminfo'
require 'curses'
require_relative 'cell'
require_relative 'cycle_handler'
require 'byebug'

include Curses

class GameOfLife
  attr_reader :height, :width, :cells

  NUM_STEPS_PER_RUN = 500
  REFRESH_RATE = 0#.01

  def initialize
    screen_size = TermInfo.screen_size
    @height = screen_size[0]
    @width = screen_size[1]
    create_cells
  end

  def setup
    Curses.init_screen
    Curses.start_color

    Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK)
    Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)
    Curses.init_pair(COLOR_GREEN,COLOR_GREEN,COLOR_BLACK)

    init_cells
  end

  def run(steps = NUM_STEPS_PER_RUN)
    steps.times do
      run_cycle
    end
  end

  private

  def cycle_cells
    @cells = CycleHandler.new(@cells, @height, @width).cycle_cells
  end

  def random_state
    [Cell::ALIVE, Cell::DEAD].sample
  end

  def random_char
    %w(. x o * X O).sample
  end

  def run_cycle
    update_screen
    cycle_cells
    #sleep REFRESH_RATE
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

  def update_screen
    for_each_cell do |cell, x, y|
      Curses.setpos(x, y)
      print_cell(cell)
    end
    Curses.refresh
  end

  def print_cell(cell)
    Curses.attron(color_pair(cell.color)|A_NORMAL) do
      Curses.addstr(cell.char)
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
    @cells = Array.new(@height) { Array.new(@width) { Cell.new(random_char) } }
  end
end
