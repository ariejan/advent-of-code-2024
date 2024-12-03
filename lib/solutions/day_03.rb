class Day03
  REGEX_1 = /mul\((\d{1,3}),(\d{1,3})\)/
  REGEX_2 = /(mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\))/

  def part_one(input)
    input.scan(REGEX_1).map do |match|
      match.map(&:to_i).inject(:*)
    end.sum
  end

  def part_two(input)
    matches = input.scan(REGEX_2)
    result = 0
    enabled = true

    matches.each do |match|
      instruction = match[0][0..2]
      case instruction
      when 'mul'
        result += match[1].to_i * match[2].to_i if enabled
      when 'do('
        enabled = true
      when 'don'
        enabled = false
      end
    end

    result
  end
end
