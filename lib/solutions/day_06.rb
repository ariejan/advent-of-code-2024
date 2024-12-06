require 'set'
require 'parallel'

class Day06
  attr_accessor :grid, :w, :h, :visited, :gx, :gy, :gdir, :logs

  DIRECTIONS = [[0, -1], [1, 0], [0, 1], [-1, 0]]

  def part_one(input)
    parse_input(input)
    @logs = []

    travel1!
  end

  def travel1!
    # Mark current posistion as visited
    visit!(@gx, @gy)

    loop do
      direction = DIRECTIONS[@gdir]
      nx = @gx + direction[0]
      ny = @gy + direction[1]
      next_position = get_xy(nx, ny)

      case next_position
      when '@'
        return @visited.flatten.count(true)
      when '.', '^' # Move forward
        @gx += direction[0]
        @gy += direction[1]
        visit!(@gx, @gy)
      when '#' # Turn
        @gdir = (@gdir + 1) % 4
      end
    end
  end

  def part_two(input)
    parse_input(input)

    # Keep for each iteration
    @guard_start_x = @gx
    @guard_start_y = @gy
    @guard_start_dir = @gdir

    # Run travel1! to get the route we can place obstacles on
    travel1!
    positions_to_check = []
    @visited.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        positions_to_check << [x, y] if cell
      end
    end

    loop_positions = Parallel.map(positions_to_check, in_processes: Parallel.processor_count) do |x, y|
      # Clone the grid and guard state for each parallel process
      grid_clone = Marshal.load(Marshal.dump(@grid))
      gx_clone = @guard_start_x
      gy_clone = @guard_start_y
      gdir_clone = @guard_start_dir

      # Place obstruction
      grid_clone[y][x] = '#'

      # Run to check for loop
      [x, y] if travel2!(grid_clone, gx_clone, gy_clone, gdir_clone)
    end

    loop_positions.compact.size
  end

  def travel2!(grid, gx, gy, gdir)
    logs = []
    history_length = 2 * (grid.size + grid[0].size) # Perimeter of the grid

    loop do
      direction = DIRECTIONS[gdir]
      nx = gx + direction[0]
      ny = gy + direction[1]

      next_position = nx < 0 || nx >= grid[0].size || ny < 0 || ny >= grid.size ? '@' : grid[ny][nx]

      return true if logs.include?([nx, ny, gdir])

      case next_position
      when '@'
        return false
      when '.', '^' # Move forward
        gx = nx
        gy = ny
      when '#' # Turn
        logs << [nx, ny, gdir]
        logs.shift if logs.size > history_length

        gdir = (gdir + 1) % 4
      end
    end
  end

  def travel!
    @logs = []
    @history_length = 2 * (@grid.size + @grid[0].size) # Perimeter of the grid

    # Mark current posistion as visited
    visit!(@gx, @gy)

    loop do
      direction = DIRECTIONS[@gdir]
      nx = @gx + direction[0]
      ny = @gy + direction[1]
      next_position = get_xy(nx, ny)

      return true if @logs.include?([nx, ny, @gdir])

      case next_position
      when '@'
        return false
      when '.', '^' # Move forward
        @gx += direction[0]
        @gy += direction[1]
        visit!(nx, ny)
        log!(nx, ny, @gdir)
      when '#' # Turn
        @gdir = (@gdir + 1) % 4
      end
    end
  end

  def parse_input(input)
    # Parse grid
    @grid = input.split("\n").map(&:chars)
    @w = @grid[0].size
    @h = @grid.size

    # Track visisted nodes
    @visited = Array.new(@h) { Array.new(@w, false) }

    # Find guard location
    idx = input.split("\n").join.chars.index('^')
    @gx = idx % @w
    @gy = idx / @w
    @gdir = 0
  end

  def visit!(x, y)
    @visited[y][x] = true
  end

  def log!(x, y, dir)
    @logs.shift if @logs.size >= @history_length
    @logs << [x, y, dir]
  end

  def set_xy(x, y, val)
    @grid[y][x] = val
  end

  def get_xy(x, y)
    return '@' if x < 0 || x >= @w || y < 0 || y >= @h

    @grid[y][x]
  end
end
