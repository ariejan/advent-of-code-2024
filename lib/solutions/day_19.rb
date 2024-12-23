class Day19 
  def part_one(input)
    sim = DayOne.new(input)
    sim.run!
  end

  def part_two(input)
    sim = DayTwo.new(input)
    sim.run!
  end

  class DayTwo
    def initialize(input)
      lines = input.split("\n")
      @towels = lines[0].split(",").map(&:strip)
      @patterns = lines[2..-1]
    end

    def possible?(pattern)
      possibles = Array.new(pattern.size + 1, 0)
      possibles[0] = 1

      (0...pattern.size).each do |i|
        next if possibles[i] == 0
        @towels.each do |towel|
          if pattern[i..-1].start_with?(towel)
            possibles[i + towel.size] += possibles[i]
          end
        end
      end

      possibles[pattern.size]
    end

    def run!
      @patterns.reduce(0) { |count, pattern| count += possible?(pattern) }
    end
  end

  class DayOne
    def initialize(input)
      lines = input.split("\n")
      @towels = lines[0].split(",").map(&:strip)
      @patterns = lines[2..-1]
    end

    def possible?(pattern)
      possibles = Array.new(pattern.size + 1, false)
      possibles[0] = true

      (0...pattern.size).each do |i|
        next unless possibles[i]
        @towels.each do |towel|
          if pattern[i..-1].start_with?(towel)
            possibles[i + towel.size] = true
          end
        end
      end

      possibles[pattern.size]
    end

    def run!
      @patterns.count { |pattern| possible?(pattern) }
    end
  end
end


