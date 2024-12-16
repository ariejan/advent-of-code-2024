require 'set'

class Day16 
  class DayOne
    DIRECTIONS = [
      [0, -1],  # North
      [1, 0],   # East
      [0, 1],   # South
      [-1, 0]   # West
    ]
    
    TURN_COST = 1000
    MOVE_COST = 1

    def initialize(input)
      @grid = input.split("\n")
      @rows = @grid.size
      @cols = @grid[0].size
    end

    def run!
      # Run, Dijkstra, Run!
      start_xy = find_cell('S')
      end_xy = find_cell('E')

      direction = 1 # East

      # 3D array to keep track of distances from each cell
      distances = Array.new(@cols) { Array.new(@rows) { Array.new(4, Float::INFINITY) } }
      
      # Start cell
      distances[start_xy[0]][start_xy[1]][direction] = 0

      # Priority queue for [cost, x, y, direction]
      p_queue = []
      p_queue << [0, start_xy[0], start_xy[1], direction]

      while !p_queue.empty?
        # Sort priority queueu by cost
        p_queue.sort_by! { |a| a[0] }

        # Get next items from queue
        cost, x, y, direction = p_queue.shift

        # Reached end
        return cost if x == end_xy[0] && y == end_xy[1]

        # Skip if we already have a lower cost to this cell
        next if distances[x][y][direction] < cost

        # Try moving forward
        new_x = x + DIRECTIONS[direction][0]
        new_y = y + DIRECTIONS[direction][1]

        if can_move?(new_x, new_y)
          new_cost = cost + MOVE_COST
          if new_cost < distances[new_x][new_y][direction]
            distances[new_x][new_y][direction] = new_cost
            p_queue << [new_cost, new_x, new_y, direction]
          end
        end

        # Try turning
        # Left
        left_dir = (direction - 1) % 4
        new_cost = cost + TURN_COST
        # Turning costs, even if we do not move. But only do it if moving
        # afterwards makes sense
        if new_cost < distances[x][y][left_dir]
          distances[x][y][left_dir] = new_cost
          p_queue << [new_cost, x, y, left_dir]
        end

        # Right
        right_dir = (direction + 1) % 4
        new_cost = cost + TURN_COST

        if new_cost < distances[x][y][right_dir]
          distances[x][y][right_dir] = new_cost
          p_queue << [new_cost, x, y, right_dir]
        end
      end

      # Can't move forward...
      return Float::INFINITY
    end

    def can_move?(x, y)
      return false if x < 0 || x >= @cols
      return false if y < 0 || y >= @rows
      return false if @grid[y][x] == '#'
      true
    end
      

    def find_cell(ch)
      @grid.each_with_index do |row, y|
        x = row.index(ch)
        if x
          puts "Found #{ch} at #{x}, #{y}"
          return [x, y]
        end
      end
      nil
    end
  end

  def part_one(input)
    sim = DayOne.new(input)
    sim.run!
  end

  def part_two(input)
    0
  end
end

