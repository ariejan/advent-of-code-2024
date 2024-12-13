class Day13
  def part_one(input)
    run(input, 100)
  end

  def part_two(input)
    run(input, nil)
  end

  def run(input, max_presses = nil)
    input.split(/(?:^\r?\n)+/).map do |block|
      lines = block.split("\n")
      a_match = lines[0].match(/^Button A:\s+X\+(\d+),\s+Y\+(\d+)$/)
      b_match = lines[1].match(/^Button B:\s+X\+(\d+),\s+Y\+(\d+)$/)
      prize_match = lines[2].match(/^Prize:\s+X=(\d+),\s+Y=(\d+)$/)

      prize_x = prize_match[1].to_i
      prize_y = prize_match[2].to_i

      if max_presses.nil?
        prize_x += 10_000_000_000_000
        prize_y += 10_000_000_000_000
      end

      ClawMachine.new(
        a_match[1].to_i,
        a_match[2].to_i,
        b_match[1].to_i,
        b_match[2].to_i,
        prize_x,
        prize_y,
        max_presses
      )
    end.map(&:solve!)
       .compact
       .map(&:first)
       .sum
  end
end

class ClawMachine
  attr_accessor :ax, :ay, :bx, :by, :prize_x, :prize_y, :max_presses

  COST_A = 3
  COST_B = 1

  def initialize(ax, ay, bx, by, prize_x, prize_y, max_presses = nil)
    @ax = ax
    @ay = ay
    @bx = bx
    @by = by
    @prize_x = prize_x
    @prize_y = prize_y
    @max_presses = max_presses
  end

  def solve!
    if max_presses.nil?
      advanced_math_solution!
    else
      brute_force!
    end
  end

  def brute_force!
    cheapest = nil

    (0..max_presses).each do |a|
      (0..max_presses).each do |b|
        # Check if this combination hits the prize location
        if a * ax + b * bx == prize_x && a * ay + b * by == prize_y
          cost = COST_A * a + COST_B * b
          cheapest = [cost, a, b] if cheapest.nil? || cost < cheapest[0]
        end
      end
    end

    cheapest
  end

  def advanced_math_solution!
    # SEe https://en.wikipedia.org/wiki/Cramer%27s_rule
    # Applications -> Small systems

    # WE need to solve
    # A.ax + B.bx = prize_x
    # A.ay + B.by = prize_y

    # Enter the matrix
    # [ ax bx ] [ A ] = [ prize_x]
    # [ ay by ] [ B ] = [ prize_y]

    # compute Determinatn
    det = ax * by - ay * bx
    return nil if det == 0

    # Check if there is an int solution
    _a = (prize_x * by - prize_y * bx)
    _b = (ax * prize_y - ay * prize_x)
    return nil unless _a % det == 0 && _b % det == 0

    # Verify we have positive solutions
    push_a = _a / det
    push_b = _b / det
    return nil if push_a < 0 || push_b < 0

    # Done ;-)
    [COST_A * push_a + COST_B * push_b, push_a, push_b]
  end
end
