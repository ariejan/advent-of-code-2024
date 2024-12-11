class Day09
  attr_accessor :input, :disk, :checksum

  def part_one(input)
    # Parse input
    parse_input(input)

    # Defrag
    defrag!
    @disk.compact!

    checksum!
    @checksum
  end

  def part_two(input)
    parse_input(input)

    # Defrag
    defrag2!

    checksum!
    @checksum
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

  def defrag2!
    # @files is now an array of tuples: [id, start, length]
    chunkers = @disk.map { |e| e || '.' }.chunk { |y| y }
    _, @files = chunkers.each_with_object([0, []]) do |(k, chunk), memo|
      memo[1] << [k, memo[0], chunk.size]
      memo[0] += chunk.length
    end

    @inputs = @files.dup.select { |b| b[0] != '.' }.reverse
    @inputs.each do |filler|
      gap_needed = filler[2]

      block = @files.find { |b| b[0] == '.' && b[2] >= gap_needed }

      next if block.nil? || block[1] >= filler[1]

      base = block[1]

      # Copy data on @disk
      0.upto(filler[2] - 1) do |i|
        @disk[base + i] = @disk[filler[1] + i]
        @disk[filler[1] + i] = nil
      end

      # Update @files
      block_idx = @files.index(block)
      @files.delete_at(block_idx)
      @files.insert(block_idx, ['.', block[1] + filler[2], block[2] - filler[2]])
      @files.delete(filler)
    end
  end

  def place_file!(idx, space)
  end

  def checksum!
    @checksum = 0
    @disk.each_with_index { |id, idx| @checksum += idx * id unless id.nil? }
  end
end
