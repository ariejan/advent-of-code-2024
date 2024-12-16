require 'set'

class Day16 

  class DayTwo
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
        # return cost if x == end_xy[0] && y == end_xy[1]

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

      # Moar work to do, backtracking steps for best cost
      best_cost = 4.times.map { |d| distances[end_xy[0]][end_xy[1]][d] }.min
      return Float::INFINITY if best_cost == Float::INFINITY

      on_shortest_path = Array.new(@cols) { Array.new(@rows) { Array.new(4, false) } }    
      queue = []

      4.times do |d|
        if distances[end_xy[0]][end_xy[1]][d] == best_cost
          on_shortest_path[end_xy[0]][end_xy[1]][d] = true
          queue << [end_xy[0], end_xy[1], d]
        end
      end

      shortest_path_cells = Set.new
      shortest_path_cells << end_xy

      
      
      while !queue.empty?
        x, y, d = queue.shift
        cost_here = distances[x][y][d]

        # Check moves
        new_x = x - DIRECTIONS[d][0]
        new_y = y - DIRECTIONS[d][1]
        if distances[new_x][new_y][d] + MOVE_COST == cost_here && can_move?(x, y)
          if !on_shortest_path[new_x][new_y][d]
            on_shortest_path[new_x][new_y][d] = true
            shortest_path_cells << [new_x, new_y]
            queue << [new_x, new_y, d]
          end
        end

        # Check turns
        left_dir = (d - 1) % 4
        if distances[x][y][left_dir] + TURN_COST == cost_here
          unless on_shortest_path[x][y][left_dir]
            on_shortest_path[x][y][left_dir] = true
            shortest_path_cells << [x, y]
            queue << [x, y, left_dir]
          end
        end

        right_dir = (d + 1) % 4
        if distances[x][y][right_dir] + TURN_COST == cost_here
          unless on_shortest_path[x][y][right_dir]
            on_shortest_path[x][y][right_dir] = true
            shortest_path_cells << [x, y]
            queue << [x, y, right_dir]
          end
        end
      end

      shortest_path_cells.size
    end

    def can_move?(x, y)
      return false if x < 0 || x >= @cols
      return false if y < 0 || y >= @rows
      return false if @grid[y][x] == '#'
      true
    end

    def inside?(x, y) 
      x >= 0 && x < @cols && y >= 0 && y < @rows
    end
      

    def find_cell(ch)
      @grid.each_with_index do |row, y|
        x = row.index(ch)
        if x
          return [x, y]
        end
      end
      nil
    end
  end

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
    sim = DayTwo.new(input)
    sim.run!
  end
end

