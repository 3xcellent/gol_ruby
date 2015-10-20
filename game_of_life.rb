class GameOfLife
  attr_reader :height, :width

  def initialize(height:, width:)
    @height = height
    @width = width
  end
end
