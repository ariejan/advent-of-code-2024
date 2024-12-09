class Day09
  attr_accessor :input, :disk, :checksum

  def part_one(input)
    # Parse input
    parse_input(input)

    # Defrag
    defrag!
    @disk.compact!

    checksum!

    # Calc checksum
    @checksum
  end

  def part_two(input)
    0
  end

  def parse_input(input)
    @input = input.chars.map(&:to_i)

    @disk = []
    is_file = true
    id = 0
    @input.each do |inp|
      if is_file
        inp.times { @disk << id }
        id += 1
      else
        inp.times { @disk << nil }
      end

      is_file = !is_file
    end
  end

  def defrag!
    (@disk.length - 1).downto(0) do |i|
      next if @disk[i].nil?

      first_nil_idx = @disk.index(nil)

      @disk[first_nil_idx] = @disk[i]
      @disk[i] = nil
    end
  end

  def checksum!
    @checksum = 0
    @disk.each_with_index { |id, idx| @checksum += idx * id }
  end
end
