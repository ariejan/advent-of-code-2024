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

  def part_two(input)
    0
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
