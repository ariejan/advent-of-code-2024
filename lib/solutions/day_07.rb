class Day07
  attr_accessor :equations

  def part_one(input)
    @equations = input.split("\n").map { |l| Equation.new(l) }
    @equations.select { |e| e.valid? }.map(&:result).sum
  end

  def part_two(input)
    0
  end
end

class Equation
  attr_accessor :result, :inputs

  OPERATORS = %i[+ *]

  def valid?
    try_combinations(@inputs[0], 1)
  end

  def try_combinations(total, idx)
    return total == @result if idx == @inputs.size

    OPERATORS.each do |op|
      new_value = total.send(op, @inputs[idx])
      return true if try_combinations(new_value, idx + 1)
    end
    false
  end

  def initialize(input)
    parts = input.split(':')
    @result = parts[0].to_i
    @inputs = parts[1].split(' ').map(&:to_i)
  end
end
