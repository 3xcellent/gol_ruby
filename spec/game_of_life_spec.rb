require_relative '../game_of_life'

describe GameOfLife do
  let(:height) { 4 }
  let(:width) { 5 }

  before do
    allow(TermInfo).to receive(:screen_size) { [height, width] }
  end

  describe 'a two-dimensional grid of square cells' do
    it 'sets the height and width' do
      expect(subject.height).to be height
      expect(subject.width).to be width
    end

    it 'creates the correct grid of cells' do
      expect(subject.cells.count).to be height
      subject.cells.each do |row|
        expect(row.count).to be width
      end
    end
  end

  describe '#setup' do
    it 'initialized curses' do
      expect(Curses).to receive(:init_screen)
      subject.setup
    end
  end

  describe '#run' do
    let(:num_steps) { 10 }

    it 'steps the game through the correct number of cycles' do
      expect(subject).to receive(:run_cycle).exactly(num_steps).times
      subject.run(num_steps)
    end
  end

  describe '#run_cycle' do
    it 'prints and cycles the cells' do
      expect(subject).to receive(:print_output)
      expect(subject).to receive(:cycle_cells)
      subject.run_cycle
    end
  end

  describe '#output' do
    let(:expected_output) { "*   *" +
                            " *   " +
                            "  *  " +
                            "   * " }

    it 'represents the gameboard correctly' do
      subject.cells[0][0].set_state(true)
      subject.cells[1][1].set_state(true)
      subject.cells[2][2].set_state(true)
      subject.cells[3][3].set_state(true)
      subject.cells[0][4].set_state(true)

      expect(subject.output).to eq expected_output
    end
  end

  describe '#cycle_cells' do
    let(:expected_cells) { double 'expected cells returned' }
    let(:cycle_handler) { double 'cycle handler' }

    it 'uses the cycle_handler to cycle the cells' do
      expect(CycleHandler).to receive(:new).with(subject.cells, subject.height, subject.width) { cycle_handler }
      expect(cycle_handler).to receive(:cycle_cells) { expected_cells }
      subject.cycle_cells
      expect(subject.cells).to be expected_cells
    end
  end
end
