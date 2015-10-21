class Cell
  attr_reader :alive

  def initialize(alive = false)
    @alive = alive
  end

  def alive?
    @alive
  end
end
