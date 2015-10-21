require_relative '../game_of_life'


describe GameOfLife do
  let(:height) { 9 }
  let(:width) { 11 }

  before do
    allow(TermInfo).to receive(:screen_size) { [height, width] }
  end

  describe 'a two-dimensional grid of square cells' do
    it 'has a height and width' do
      expect(subject.height).to be height
      expect(subject.width).to be width

      expect(subject.cells.count).to be height
      subject.cells.each do |row|
        expect(row.count).to be width
      end
    end
  end
end
