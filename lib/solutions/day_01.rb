class Day01
  def part_one(input)
    list_a = []
    list_b = []

    # Split lists of inputs
    input.split("\n").each do |line|
      parts = line.split(' ')
      list_a << parts[0].to_i
      list_b << parts[1].to_i
    end

    list_a.sort!
    list_b.sort!

    solution = 0
    list_a.each_with_index do |a, i|
      solution += (a - list_b[i]).abs
    end

    solution
  end

  def part_two(input)
    list_a = []
    list_b = []

    # Split lists of inputs
    input.split("\n").each do |line|
      parts = line.split(' ')
      list_a << parts[0].to_i
      list_b << parts[1].to_i
    end

    solution = 0
    list_a.each_with_index do |a, _i|
      solution += a * list_b.count(a)
    end

    solution
  end
end
