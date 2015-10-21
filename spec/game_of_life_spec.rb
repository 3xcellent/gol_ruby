require_relative '../game_of_life'


describe GameOfLife do
  let(:height) { 9 }
  let(:width) { 11 }

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
    let(:expected_output) { ' ' * height*width }

    it 'represents the gameboard correctly' do
      expect(subject.output).to eq expected_output
    end
  end
end
