class Cell
  attr_reader :alive

  def initialize(alive = false)
    @alive = alive
  end

  def alive?
    @alive
  end

  def set_alive
    @alive = true
  end
end
