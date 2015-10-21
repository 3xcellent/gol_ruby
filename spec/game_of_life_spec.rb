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

  describe '#output' do
    let(:expected_output) { "*   *" +
                            " *   " +
                            "  *  " +
                            "   * " }

    it 'represents the gameboard correctly' do
      subject.cells[0][0].set_alive
      subject.cells[1][1].set_alive
      subject.cells[2][2].set_alive
      subject.cells[3][3].set_alive
      subject.cells[0][4].set_alive

      expect(subject.output).to eq expected_output
    end
  end

end
