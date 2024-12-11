class Day11
  attr_accessor :stones, :iterations, :cache

  # Notes:
  #  - Keeping input as String is faster when splitting, only convert to int when needed
  #  - Caching is key
  #  - Count, don't keep resulting stone values in memory.

  def initialize
    @cache = {}
  end

  def part_one(input)
    run(input, 25)
  end

  def part_two(input)
    run(input, 75)
  end

  def run(input, iterations)
    @stones = input.split(' ')
    @iterations = iterations

    result = 0
    @stones.each { |s| result += count_stones_after(s, iterations) }
    result
  end

  def count_stones_after(stone, iterations)
    return 1 if iterations == 0

    cache_key = [stone, iterations].freeze
    return @cache[cache_key] if @cache.key?(cache_key)

    next_iter = blink(stone)

    total = 0
    next_iter.each { |s| total += count_stones_after(s, iterations - 1) }
    @cache[cache_key] = total
    total
  end

  def blink(stone)
    if stone == '0'
      ['1']
    elsif stone.size.even?
      split_digits(stone)
    else
      [multiply(stone, 2024)]
    end
  end

  def multiply(stone, factor)
    (stone.to_i * factor).to_s
  end

  def split_digits(stone)
    split = stone.size / 2
    left = stone[0...split].sub(/^0+/, '') # Remove leading zeros on left half
    left = '0' if left.empty?
    right = stone[split..-1].sub(/^0+/, '') # Remove leading zeros on right half
    right = '0' if right.empty?
    [left, right]
  end
end
