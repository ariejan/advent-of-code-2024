class Day11
  attr_accessor :stones, :blinks

  def part_one(input)
    @stones = input.split(' ').map(&:to_i)

    25.times { blink! }

    @stones.size
  end

  def blink!
    new_stones = []
    @stones.each_with_index do |stone, i|
      value_s = stone.to_s

      if stone == 0
        new_stones[i] = 1
      elsif value_s.length.even?
        split = value_s.length / 2
        new_stones[i] = [value_s[0...split].to_i, value_s[split..-1].to_i]
      else
        new_stones[i] = stone * 2024
      end
    end
    
    @stones = new_stones.flatten!
  end

  def part_two(input)
    @stones = input.split(' ').map(&:to_i)

    75.times { blink! }

    @stones.size
  end
end
