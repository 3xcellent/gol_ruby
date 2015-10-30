class CycleHandler

  def initialize(cells, height, width)
    @cells = cells
    @height = height
    @width = width
  end

  def cycle_cells
    set_next_states
    step_cells
    @cells
  end

  private

  def set_next_states
    for_each_cell do |cell, x, y|
      cell.set_next_state(number_living_neighbors(x, y))
    end
  end

  def number_living_neighbors(cell_x, cell_y)
    num_alive = 0

    ((cell_x - 1)..(cell_x+1)).each do |x|
      next if x < 0 || x >= @height

      (cell_y-1..cell_y+1).each do |y|
        next if y < 0 || y >= @width || (x==cell_x && y==cell_y)

        num_alive += 1 if @cells[x][y].alive?
      end
    end

    num_alive
  end

  def step_cells
    for_each_cell do |cell|
      cell.step
    end
  end

  def for_each_cell(&block)
    @cells.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        case block.arity
        when 0
          yield
        when 1
          yield cell
        when 3
          yield cell, x, y
        end
      end
    end
  end
end
