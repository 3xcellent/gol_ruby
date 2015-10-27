# The universe of the Game of Life
#  - is an infinite two-dimensional orthogonal grid of square cells
#  - each of which is in one of two possible states, alive or dead.
#  -  Every cell interacts with its eight neighbours,
#       which are the cells that are horizontally,
#       vertically, or diagonally adjacent.
#
# At each _step_ in time, the following transitions occur:
#  1 Any live cell with fewer than two live neighbours
#      dies, as if caused by under-population.
#  2 Any live cell with two or three live neighbours
#      lives on to the next generation.
#  3 Any live cell with more than three live neighbours
#      dies, as if by overcrowding.
#  4 Any dead cell with exactly three live neighbours
#      becomes a live cell, as if by reproduction.
#
require_relative '../cell'

describe Cell do
  describe '#alive?' do
    it 'defaults to dead' do
      expect(subject.alive?).to be false
    end
  end

  describe '#set_alive' do
    it 'sets alive to true' do
      subject.set_alive
      expect(subject.alive?).to be true
    end
  end

  describe '#step' do
    it 'sets alive to alive_next_step' do
      subject.set_alive_next_step
      subject.step
      expect(subject.alive?).to be true
    end
  end
end
