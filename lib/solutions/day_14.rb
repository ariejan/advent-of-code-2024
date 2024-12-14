class Day14
  KNOWN_TREE_PATTERN = [
    '   #   ',
    '  ###  ',
    ' ##### '
  ]
  def part_one(input, w = 101, h = 103)
    quadrants = [0, 0, 0, 0]
    wd = w / 2
    hd = h / 2

    bots = input.split("\n")
                .map { |line| line.scan(/(-?\d+)/).flatten }
                .map { |values| Robot.new(values[0].to_i, values[1].to_i, values[2].to_i, values[3].to_i, w, h) }
                .map { |bot| bot.move!(100) }
                .each do |x, y|
      if x < wd && y < hd
        quadrants[0] += 1
      elsif x > wd && y < hd
        quadrants[1] += 1
      elsif x < wd && y > hd
        quadrants[2] += 1
      elsif x > wd && y > hd
        quadrants[3] += 1
      end
    end

    quadrants.inject(:*)
  end

  def part_two(input, w = 101, h = 103)
    bots = input.split("\n")
                .map { |line| line.scan(/(-?\d+)/).flatten }
                .map { |values| Robot.new(values[0].to_i, values[1].to_i, values[2].to_i, values[3].to_i, w, h) }

    moves = 0
    loop do
      coords = bots.map(&:p)
      grid = to_grid(w, h, coords)
      bounding_box = bounding_box(coords)

      pattern = extract_pattern(grid, bounding_box)

      if matches_christmas_tree?(pattern)
        puts "Found it after #{moves} moves"
        display_bots(w, h, coords)
        break
      end

      bots.map(&:move!)
      moves += 1
    end
  end

  def to_grid(w, h, coords)
    grid = Array.new(h) { Array.new(w, '.') }
    coords.each do |x, y|
      grid[y][x] = '#'
    end
    grid
  end

  def bounding_box(coords)
    x_values = coords.map { |x, _| x }
    y_values = coords.map { |_, y| y }

    [x_values.min, y_values.min, x_values.max, y_values.max]
  end

  def extract_pattern(grid, bounding_box)
    x_min, y_min, x_max, y_max = bounding_box
    pattern = []
    (y_min..y_max).each do |y|
      row = grid[y][x_min..x_max].join
      pattern << row
    end
    pattern
  end

  def matches_christmas_tree?(pattern)
    pattern[0].count('#') == 1 &&
      (pattern[1].count('#') == 2 || pattern[1].count('#') == 3) &&
      (pattern[1].count('#') == 2 || pattern[1].count('#') == 5)
  end

  def display_bots(w, h, coords)
    grid = Array.new(h) { Array.new(w, '.') }
    coords.each do |x, y|
      grid[y][x] = '#'
    end
    grid.each do |row|
      puts row.join
    end
  end

  def all_semetrical(coords)
  end
end

class Robot
  attr_accessor :px, :py, :vx, :vy, :w, :h

  def initialize(px, py, vx, vy, w, h)
    @px = px
    @py = py
    @vx = vx
    @vy = vy
    @w = w
    @h = h
  end

  def p
    [px, py]
  end

  def move!(steps = 1)
    @px = (@px + (steps * @vx)) % @w
    @py = (@py + (steps * vy)) % @h

    p
  end
end
