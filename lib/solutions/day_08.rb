require 'matrix'

class Day08
  attr_accessor :grid, :w, :h, :nodes, :antinodes

  def part_one(input)
    parse_input(input)

    @nodes.each_pair do |_node, coords|
      find_antinodes(coords)
    end

    @antinodes.flatten.count(true)
  end

  def part_two(_input)
    0
  end

  def mark_antinode(x, y)
    @counter ||= 0
    @counter += 1

    # print "M #{@counter}: #{x}, #{y} (#{@w}x#{@h})"

    if x < 0 || x >= @w || y < 0 || y >= @h
      # puts '- OUT'
      return
    end

    # puts ' - OK'

    @antinodes[y][x] = true
  end

  def find_antinodes(coords)
    # Loop through all coordinate pemutations
    coords.permutation(2).to_a.each do |a, b|
      dx = b[0] - a[0]
      dy = b[1] - a[1]

      mark_antinode(a[0] - dx, a[1] - dy)
    end
  end

  def parse_input(input)
    # Parse grid
    @grid = input.split("\n").map(&:chars)
    @w = @grid[0].size
    @h = @grid.size

    # Track visisted nodes
    @visited = Array.new(@h) { Array.new(@w, false) }

    # Find antenna locations
    @nodes = {}
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell != '.'
          @nodes[cell] ||= []
          @nodes[cell] << [x, y]
        end
      end
    end

    @antinodes = Array.new(@h) { Array.new(@w, false) }
  end
end
