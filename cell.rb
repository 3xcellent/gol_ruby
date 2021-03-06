class Cell
  attr_reader :next_state

  ALIVE = true
  DEAD  = false

  def initialize(state = DEAD)
    @state = state
  end

  def alive?
    @state
  end

  def set_state(state)
    @state = state
  end

  def step
    @state = @next_state
  end

  def set_next_state(neighbors_alive)
    @next_state = alive_next_state? neighbors_alive
  end

  private

  def alive_next_state?(n)
    (alive? && (n == 2 || n == 3)) || (! alive? && n == 3)
  end
end
