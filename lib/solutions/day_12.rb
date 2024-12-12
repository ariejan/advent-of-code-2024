class Day12
  def part_one(input)
    Day12Part1.new.part_one(input)
  end

  def part_two(input)
    Day12Part2.new.part_two(input)
  end
end

class Day12Part2
  def part_two(input)
    @map = input.split("\n")
    @rows = @map.length
    @cols = @map[0].length
    @visited = Array.new(@rows) { Array.new(@cols, false) }

    @grid = Grid.new(@map)

    price_perimeter, price_sides = @grid.calculate_price_area_perimeter

    puts "Price perimeter: #{price_perimeter}"
    puts "Price sides: #{price_sides}"

    price_sides
  end
end

class Day12Part1
  def part_one(input)
    @map = input.split("\n")
    @rows = @map.length
    @cols = @map[0].length
    @visited = Array.new(@rows) { Array.new(@cols, false) }

    total_price
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

class Grid
  attr_reader :width, :height

  def initialize(grid)
    @grid = grid
    @height = @grid.size
    @width = @grid[0].size
    @visited = Array.new(@height) { Array.new(@width, false) }

    # directions: up, down, left, right
    @directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  end

  def on_map?(x, y)
    # check if x, y coord exist
    x.between?(0, @height - 1) && y.between?(0, @width - 1)
  end

  def find_plot_BFS(start_x, start_y)
    plant_type = @grid[start_x][start_y]
    queue = [[start_x, start_y]]
    @visited[start_x][start_y] = true

    area = 0
    perimeter = 0
    cells = Set.new([[start_x, start_y]])

    until queue.empty?
      x, y = queue.shift
      area += 1

      @directions.each do |dx, dy|
        nx = x + dx
        ny = y + dy

        if on_map?(nx, ny)
          if @grid[nx][ny] == plant_type && !@visited[nx][ny]
            @visited[nx][ny] = true
            queue << [nx, ny]
            cells.add([nx, ny])
          elsif @grid[nx][ny] != plant_type
            perimeter += 1
          end
        else
          # Out of bounds contributes to perimeter
          perimeter += 1
        end
      end
    end

    # Calculate the number of sides (== corners) for the plot
    sides = calculate_corners(cells)
    [area, perimeter, sides]
  end

  def calculate_corners(cells)
    corners = 0

    cells.each do |cell|
      x, y = cell
      u = [x - 1, y]     # Up
      d = [x + 1, y]     # Down
      r = [x, y + 1]     # Right
      l = [x, y - 1]     # Left

      # External corners
      corners += 1 if !cells.include?(u) && !cells.include?(r)
      corners += 1 if !cells.include?(r) && !cells.include?(d)
      corners += 1 if !cells.include?(d) && !cells.include?(l)
      corners += 1 if !cells.include?(l) && !cells.include?(u)

      # Internal (diagonal) corners
      ur = [x - 1, y + 1] # Up-Right
      ul = [x - 1, y - 1] # Up-Left
      dr = [x + 1, y + 1] # Down-Right
      dl = [x + 1, y - 1] # Down-Left

      corners += 1 if cells.include?(u) && cells.include?(r) && !cells.include?(ur)
      corners += 1 if cells.include?(r) && cells.include?(d) && !cells.include?(dr)
      corners += 1 if cells.include?(d) && cells.include?(l) && !cells.include?(dl)
      corners += 1 if cells.include?(l) && cells.include?(u) && !cells.include?(ul)
    end

    corners
  end

  def calculate_price_area_perimeter
    total_price_perimeter = 0
    total_price_sides = 0
    @visited = Array.new(@height) { Array.new(@width, false) }

    @height.times do |x|
      @width.times do |y|
        next if @visited[x][y]

        area, perimeter, sides = find_plot_BFS(x, y)
        total_price_perimeter += area * perimeter
        total_price_sides += area * sides
      end
    end

    [total_price_perimeter, total_price_sides]
  end
end

