class Day10
  def part_one(input)
    thf = TrailheadFinder.new(input)
    thf.find_trailheads
  end

  def part_two(input)
    thf = TrailheadFinder.new(input)
    thf.find_trailheads_with_rating
  end
end

class TrailheadFinder
  attr_accessor :grid, :w, :h

  def initialize(input)
    # Parse grid
    @grid = input.split("\n").map { |line| line.chars.map(&:to_i) }
    @w = @grid[0].size
    @h = @grid.size
  end

  def find_trailheads
    total_nines = 0

    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        total_nines += count_reachable_nines(x, y) if cell == 0
      end
    end

    total_nines
  end

  def count_reachable_nines(x, y)
    visited = Array.new(@h) { Array.new(@w, false) }
    queue = [[x, y, 0]]
    reachable_nines = 0

    until queue.empty?
      cx, cy, current_value = queue.shift
      next if visited[cy][cx]

      visited[cy][cx] = true

      if @grid[cy][cx] == 9
        reachable_nines += 1
        next
      end

      [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |dx, dy|
        nx = cx + dx
        ny = cy + dy
        if nx.between?(0, @w - 1) && ny.between?(0, @h - 1) && !visited[ny][nx] && @grid[ny][nx] == current_value + 1
          queue << [nx, ny, current_value + 1]
        end
      end
    end

    reachable_nines
  end

  def find_trailheads_with_rating
    total_paths = 0

    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        total_paths += count_unique_paths(x, y) if cell == 0
      end
    end

    total_paths
  end

  def count_unique_paths(x, y)
    visited = Array.new(@h) { Array.new(@w, false) }
    paths = 0

    dfs(x, y, 0, visited, paths)
  end

  def dfs(x, y, current_value, visited, paths)
    return 0 if x < 0 || x >= @w || y < 0 || y >= @h || visited[y][x] || @grid[y][x] != current_value

    return 1 if @grid[y][x] == 9

    visited[y][x] = true
    path_count = 0

    [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |dx, dy|
      path_count += dfs(x + dx, y + dy, current_value + 1, visited, paths)
    end

    visited[y][x] = false
    path_count
  end
end
