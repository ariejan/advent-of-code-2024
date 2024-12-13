class Day13
  def part_one(input)
    input.split(/(?:^\r?\n)+/).map do |block|
      lines = block.split("\n")
      a_match = lines[0].match(/^Button A:\s+X\+(\d+),\s+Y\+(\d+)$/)
      b_match = lines[1].match(/^Button B:\s+X\+(\d+),\s+Y\+(\d+)$/)
      prize_match = lines[2].match(/^Prize:\s+X=(\d+),\s+Y=(\d+)$/)

      ClawMachine.new(
        a_match[1].to_i,
        a_match[2].to_i,
        b_match[1].to_i,
        b_match[2].to_i,
        prize_match[1].to_i,
        prize_match[2].to_i
      )
    end.map(&:solve!)
       .compact
       .map(&:first)
       .sum
  end

  def part_two(input)
    0
  end
end

class ClawMachine
  attr_accessor :ax, :ay, :bx, :by, :prize_x, :prize_y

  MAX_PRESSES = 100
  COST_A = 3
  COST_B = 1

  def initialize(ax, ay, bx, by, prize_x, prize_y)
    @ax = ax
    @ay = ay
    @bx = bx
    @by = by
    @prize_x = prize_x
    @prize_y = prize_y
  end

  def solve!
    cheapest = nil

    (0..MAX_PRESSES).each do |a|
      (0..MAX_PRESSES).each do |b|
        # Check if this combination hits the prize location
        if a * ax + b * bx == prize_x && a * ay + b * by == prize_y
          cost = COST_A * a + COST_B * b
          cheapest = [cost, a, b] if cheapest.nil? || cost < cheapest[0]
        end
      end
    end

    cheapest
  end
end
