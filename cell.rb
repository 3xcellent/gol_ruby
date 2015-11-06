class Cell
  include Curses

  attr_reader :next_state, :previous_state, :char, :color

  ALIVE = true
  DEFAULT_ALIVE_CHAR = '*'
  DEAD  = false
  DEAD_CHAR = ' '

  def initialize(alive_char = DEFAULT_ALIVE_CHAR, state = DEAD)
    @state = state
    @alive_char = alive_char

    @previous_state = DEAD
    @char = DEAD_CHAR
    @color = COLOR_BLUE
  end

  def alive?
    @state
  end

  def set_state(state)
    @state = state
  end

  def step
    @previous_state = @state
    @state = @next_state
    set_output
  end

  def set_next_state(neighbors_alive)
    @next_state = alive_next_state? neighbors_alive
  end

  private

  def alive_next_state?(n)
    (alive? && (n == 2 || n == 3)) || (! alive? && n == 3)
  end

  def set_output
    @char = alive? ? @alive_char : DEAD_CHAR

    if @previous_state == alive?
      @color = COLOR_BLUE
    elsif alive?
      @color = COLOR_GREEN
    else
      @color = COLOR_RED
      @char = @alive_char
    end
  end
end
