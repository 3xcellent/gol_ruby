require_relative '../game_of_life'

describe GameOfLife do
  let(:height) { double 'height' }
  let(:width) { double 'width' }

  before do
    allow(TermInfo).to receive(:screen_size) { [height, width] }
  end

  describe 'a two-dimensional grid of square cells' do
    it 'has a height and width' do
      expect(subject.height).to be height
      expect(subject.width).to be width
    end
  end

end
