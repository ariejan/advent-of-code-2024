class Day04
  attr_accessor :grid, :w, :h

  DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, -1], [1, -1], [-1, 1]]

  def get_xy(x, y)
    return '.' if x < 0 || x >= @w || y < 0 || y >= @h

    @grid[y][x]
  end

  def parse_input(input)
    @grid = input.split("\n").map(&:chars)
    @w = @grid[0].size
    @h = @grid.size
  end

  def brute_force(target)
    hits = 0
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        DIRECTIONS.each do |direction|
          hits += 1 if check_directions(x, y, target, direction)
        end
      end
    end
    hits
  end

  def xmas_force
    hits = 0
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        hits += 1 if get_xy(x, y) == 'A' && check_xmas(x, y)
      end
    end
    hits
  end

  def check_xmas(x, y)
    # A at x,y
    # a   b
    #   X
    # c   d
    a = get_xy(x - 1, y - 1)
    b = get_xy(x + 1, y - 1)
    c = get_xy(x - 1, y + 1)
    d = get_xy(x + 1, y + 1)

    axis_ad = a == 'M' && d == 'S' || a == 'S' && d == 'M'
    axis_bc = b == 'M' && c == 'S' || b == 'S' && c == 'M'

    axis_ad && axis_bc
  end

  def check_directions(x, y, target, direction, level = 0)
    if get_xy(x, y) == target[0]
      return true if target.size == 1

      return check_directions(x + direction[0], y + direction[1], target[1..-1], direction, level + 1)
    end

    false
  end

  def part_one(input)
    parse_input(input)
    brute_force('XMAS')
  end

  def part_two(input)
    parse_input(input)
    xmas_force
  end
end
