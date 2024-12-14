class Day14
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

    moves = 1
    loop do
      bots.map(&:move!)
      coords = bots.map(&:p)

      if all_semetrical?(w, h, coords)
        puts "--- Move #{moves} ---"
        display_bots(w, h, bots.map(&:p))
        puts ''
        break
      end

      moves += 1
    end
  end

  def all_semetrical?(w, h, coords)
    grid = Array.new(h) { Array.new(w, '.') }
    coords.each do |x, y|
      grid[y][x] = '#'
    end
    grid.all? { |row| row == row.reverse }
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
