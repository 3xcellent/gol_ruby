class Cell
  ALIVE = '*'
  DEAD = ' '

  attr_reader :state

  def initialize(state = ALIVE)
    @state = state
  end
end
