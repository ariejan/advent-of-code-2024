class Day12
  def part_one(input)
    @map = input.split("\n")
    @rows = @map.length
    @cols = @map[0].length
    @visited = Array.new(@rows) { Array.new(@cols, false) }

    total_price
  end

  def part_two(input)
    0
  end

  def total_price
    regions = find_regions
    regions.sum { |region| region[:area] * region[:perimeter] }
  end

  def find_regions
    regions = []
    (0...@rows).each do |row|
      (0...@cols).each do |col|
        next if @visited[row][col]

        char = @map[row][col]
        area, perimeter = explore_region(row, col, char)
        regions << { area: area, perimeter: perimeter }
      end
    end
    regions
  end

  def explore_region(row, col, char)
    queue = [[row, col]]
    area = 0
    perimeter = 0

    until queue.empty?
      current_row, current_col = queue.shift
      next if out_of_bounds?(current_row, current_col) || @visited[current_row][current_col]

      next unless @map[current_row][current_col] == char

      @visited[current_row][current_col] = true
      area += 1

      # Check all four directions
      [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |dr, dc|
        new_row = current_row + dr
        new_col = current_col + dc
        if out_of_bounds?(new_row, new_col) || @map[new_row][new_col] != char
          perimeter += 1
        else
          queue << [new_row, new_col] unless @visited[new_row][new_col]
        end
      end
    end

    [area, perimeter]
  end

  def out_of_bounds?(row, col)
    row < 0 || row >= @rows || col < 0 || col >= @cols
  end
end
