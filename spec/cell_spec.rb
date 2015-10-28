# The universe of the Game of Life
#  - is an infinite two-dimensional orthogonal grid of square cells
#  - each of which is in one of two possible states, alive or dead.
#  -  Every cell interacts with its eight neighbours,
#       which are the cells that are horizontally,
#       vertically, or diagonally adjacent.
#
# At each step in time, the following transitions occur:
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

  describe '#set_state' do
    it 'sets its state' do
      subject.set_state(Cell::ALIVE)
      expect(subject.alive?).to be true
    end
  end

  describe '#step' do
    let(:current_state) { Cell::DEAD }
    let(:expected_state) { Cell::ALIVE }
    it 'sets state to next_state' do
      subject.set_state(current_state)
      subject.set_next_state(3)
      subject.step
      expect(subject.alive?).to be expected_state
    end
  end

  describe '#set_next_state' do
    shared_examples 'sets proper state' do
      it 'has proper state' do
        neighbors_alive_array.each do |i|
          subject.set_state(current_state)
          subject.set_next_state(i)
          expect(subject.next_state).to be expected_state
        end
      end
    end

    context 'when cell is alive' do
      let(:current_state) { Cell::ALIVE }

      context 'less than 2 neighbors alive' do
        #  1 Any live cell with fewer than two live neighbours
        #      dies, as if caused by under-population.
        let(:neighbors_alive_array) { [0,1] }
        let(:expected_state) { Cell::DEAD }

        it_behaves_like('sets proper state')
      end

      context '2 or 3 neighbors alive' do
        #  2 Any live cell with two or three live neighbours
        #      lives on to the next generation.
        let(:neighbors_alive_array) { [2,3] }
        let(:expected_state) { Cell::ALIVE }

        it_behaves_like('sets proper state')
      end

      context 'more than 3 neighbors alive' do
        #  3 Any live cell with more than three live neighbours
        #      dies, as if by overcrowding.
        let(:neighbors_alive_array) { [4,5,6,7,8,9] }
        let(:expected_state) { Cell::DEAD }

        it_behaves_like('sets proper state')
      end
    end

    context 'when cell is dead' do
      let(:current_state) { Cell::DEAD }
      context '3 neighbors alive' do
        #  4 Any dead cell with exactly three live neighbours
        #      becomes a live cell, as if by reproduction.
        let(:neighbors_alive_array) { [3] }
        let(:expected_state) { Cell::ALIVE }

        it_behaves_like('sets proper state')
      end

    end
  end
end
