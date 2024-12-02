class Day02
  def part_one(input)
    reports = input.split("\n").map do |line|
      line.split(' ').map(&:to_i)
    end

    reports.count { |report| valid_report?(report) }
  end

  def part_two(input)
    reports = input.split("\n").map do |line|
      line.split(' ').map(&:to_i)
    end

    reports.count { |report| valid_dampened_report?(report) }
  end

  def valid_report?(report)
    values = []
    0.upto(report.size - 2) do |i|
      values << report[i] - report[i + 1]
    end

    is_valid_increasing(values) || is_valid_decreasing(values)
  end

  def valid_dampened_report?(report)
    report.each_with_index do |_, idx|
      values = report.dup
      values.delete_at(idx)
      return true if valid_report?(values)
    end
    false
  end

  def is_valid_increasing(values)
    values.all? { |v| v >= 1 && v <= 3 }
  end

  def is_valid_decreasing(values)
    values.all? { |v| v >= -3 && v <= -1 }
  end
end
