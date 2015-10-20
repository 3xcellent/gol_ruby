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
  let(:alive) { described_class::ALIVE }
  let(:dead) { described_class::DEAD }

  subject do
    described_class.new(state)
  end

  describe '#state' do
    context 'when no state is provided' do
      let(:state) { nil }
      it 'should be alive' do
        expect(subject.state).to be alive
      end
    end

    context 'when a state is provied' do
      let(:state) { double 'state' }
      it 'should have the given state' do
        expect(subject.state).to be state
      end
    end
  end
end
