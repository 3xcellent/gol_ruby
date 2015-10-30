require_relative '../cycle_handler'

describe CycleHandler do
  describe '#cycle_cells' do

    subject do
      described_class.new(cells, height, width)
    end

    let(:height) { 3 }
    let(:width) { 3 }
    let(:cells) { Array.new(height) { Array.new(width) { Cell.new } } }
    let(:expected_cells) { Array.new(height) { Array.new(width) { Cell.new } } }

    before do
      cells[0][1].set_state(true)
      cells[1][1].set_state(true)
      cells[2][1].set_state(true)

      expected_cells[1][0].set_state(true)
      expected_cells[1][1].set_state(true)
      expected_cells[1][2].set_state(true)
    end

    it 'returns the updates cells' do
      cycled_cells = subject.cycle_cells.flatten
      expect(cycled_cells.collect(&:alive?)).to eq expected_cells.flatten.map(&:alive?)
    end
  end
end
