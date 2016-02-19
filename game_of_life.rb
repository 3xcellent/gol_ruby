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

  def cycle_cells
    @cells = CycleHandler.new(@cells, @height, @width).cycle_cells
  end

  def setup
    Curses.init_screen
    init_cells
  end

  def random_state
    [Cell::ALIVE, Cell::DEAD].sample
  end

  def run(steps = 250)
    steps.times do
      run_cycle
    end
  end

  def run_cycle
    print_output
    cycle_cells
    sleep 0.05
  end

  private


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

