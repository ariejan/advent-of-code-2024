require 'fileutils'

class AdventOfCode2024
  def self.run(day)
    day_str = day.to_s.rjust(2, '0')
    day_file = File.join(__dir__, 'solutions', "day_#{day_str.downcase}.rb")

    begin
      require day_file
      solution_class = Object.const_get("Day#{day_str}")

      input = File.read(
        File.join(__dir__, 'input', "day_#{day_str}.txt")
      ).strip

      puts "Part 1: #{solution_class.new.part_one(input)}"
      puts "Part 2: #{solution_class.new.part_two(input)}"
    rescue LoadError
      puts "Error: Could not find solution file for day #{day_str}"
    rescue NameError
      puts "Error: Could not find Day#{day_str} class in solution file"
    end
  end
end
