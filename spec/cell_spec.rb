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
  let(:alive) { true }
  let(:dead) { false }

  describe '#alive?' do
    it 'defaults be dead' do
      expect(subject.alive?).to be dead
    end
  end

  describe '#set_alive' do
    it 'sets alive to true' do
      subject.set_alive
      expect(subject.alive?).to be alive
    end
  end
end
