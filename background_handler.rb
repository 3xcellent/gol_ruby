class BackgroundHandler
  DEFAULT_CHAR = '.'

  def initialize(height, width)
    @height = height
    @width = width
    set_offsets
  end

  def char_for_cell(x, y)
    debugger
    return DEFAULT_CHAR if @background_rows[x+@offset_x].nil?
    @background_rows[x+@offset_x][y+@offset_y] || DEFAULT_CHAR
  end

  private

  def set_offsets
    @offset_x = start_x(background_rows.count)
    @offset_y = start_y(background_rows.group_by(&:length).max.last[0].length-1)
  end

  def start_x(image_w)
    (@width-image_w)/2
  end

  def start_y(image_h)
    #(@height-image_h)/2
    0
  end

  def background_rows
    @background_rows ||= File.readlines('assets/ascii_art/lorum_ipsum.txt')
    @background_rows
  end

  def for_each_cell_char(&block)
    @cell_chars.each_with_index do |row, x|
      row.each_with_index do |char, y|
        case block.arity
        when 0
          yield
        when 1
          yield char
        when 3
          yield char, x, y
        end
      end
    end
  end
end
