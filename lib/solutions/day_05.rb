class Day05
  def part_one(input)
    parse_input(input)

    @updates
      .select { |update| correct_order?(update) }
      .map { |result| result[result.size / 2] }
      .sum
  end

  def part_two(input)
    0
  end

  def correct_order?(update)
    @order.all? do |p1, p2|
      (update.include?(p1) && update.include?(p2) && update.index(p1) < update.index(p2)) || (!update.include?(p1) || !update.include?(p2))
    end
  end

  def parse_input(input)
    lines = input.split("\n")
    split_idx = lines.index('')

    @order = lines[0..split_idx - 1].map { |line| line.split('|').map(&:to_i) }
    @updates = lines[split_idx + 1..-1].map { |line| line.split(',').map(&:to_i) }
  end
end
