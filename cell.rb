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

  def set_alive_next_step
    @alive_next_step = true
  end

  def set_dead_next_step
    @alive_next_step = false
  end

  def step
    @alive = @alive_next_step
  end
end
