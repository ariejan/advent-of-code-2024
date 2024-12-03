class Day03
  REGEX_1 = /mul\((\d{1,3}),(\d{1,3})\)/
  def part_one(input)
    input.scan(REGEX_1).map do |match|
      match.map(&:to_i).inject(:*)
    end.sum
  end

  def part_two(input)
    0
  end
end
