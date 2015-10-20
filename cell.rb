class Cell
  ALIVE = '*'
  DEAD = ' '

  attr_reader :state

  def initialize(state)
    @state = state
  end
end
