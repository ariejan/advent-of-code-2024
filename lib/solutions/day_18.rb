class Day18 
  def part_one(input, w = 70, h = 70, run_corruptions = 1024)
    sim = DayOne.new(input, w, h, run_corruptions)
    sim.run!
  end

  def part_two(input, w = 70, h = 70, run_corruptions = 1024)
    sim = DayTwo.new(input, w, h, run_corruptions)
    sim.sim!
  end

  class DayTwo
    #Shamelessly stolen from day 16
    DIRECTIONS = [
      [0, -1],  # North
      [1, 0],   # East
      [0, 1],   # South
      [-1, 0]   # West
    ]
    
    TURN_COST = 1
    MOVE_COST = 1

    def initialize(input, w = 70, h = 70, run_corruptions = 1024)
      @rows = h + 1
      @cols = w + 1
      @run_corruptions = run_corruptions
      @grid = Array.new(@rows) { Array.new(@cols, '.') }

      @corruptions = input.split("\n").map { |l| l.split(',').map(&:to_i) }
    end

    def rain_corruption!(idx)
      @corruptions[0..idx].each do |corruption|
        set_cell(corruption, '#')
      end
    end

    def set_cell(xy, ch) 
      x, y = xy
      @grid[y][x] = ch
    end

    def to_s
      @grid.map { |r| r.join('') }
    end

    def sim!
      r = (0...@corruptions.size)

      result = r.bsearch do |corruption_index|
        # puts "BSearching #{corruption_index} - #{@corruptions[corruption_index].join(',')}"
        @grid = Array.new(@rows) { Array.new(@cols, '.') }
        rain_corruption!(corruption_index)
        run! == Float::INFINITY
      end

      @corruptions[result].join(",")
    end

    def run!
      # Run, Dijkstra, Run!
      start_xy = [0,0]
      end_xy = [@cols - 1, @rows - 1]

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
        [
          direction, 
          (direction + 1) % 4, 
          (direction + 2) % 4, 
          (direction + 3) % 4
        ].each do |new_dir|
          new_dir = (direction - 1) % 4
          new_cost = cost # + TURN_COST
     
          if new_cost < distances[x][y][new_dir]
            distances[x][y][new_dir] = new_cost
            p_queue << [new_cost, x, y, new_dir]
          end
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

  class DayOne
    #Shamelessly stolen from day 16
    DIRECTIONS = [
      [0, -1],  # North
      [1, 0],   # East
      [0, 1],   # South
      [-1, 0]   # West
    ]
    
    TURN_COST = 1
    MOVE_COST = 1

    def initialize(input, w = 70, h = 70, run_corruptions = 1024)
      @rows = h + 1
      @cols = w + 1
      @run_corruptions = run_corruptions
      @grid = Array.new(@rows) { Array.new(@cols, '.') }

      @corruptions = input.split("\n").map { |l| l.split(',').map(&:to_i) }
    end

    def rain_corruption!
      @corruptions[0...@run_corruptions].each do |corruption|
        x, y = corruption
        @grid[y][x] = '#'
      end
    end

    def to_s
      @grid.map { |r| r.join('') }
    end

    def run!
      # Run, Dijkstra, Run!
      start_xy = [0,0]
      end_xy = [@cols - 1, @rows - 1]

      rain_corruption!

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
        [
          direction, 
          (direction + 1) % 4, 
          (direction + 2) % 4, 
          (direction + 3) % 4
        ].each do |new_dir|
          new_dir = (direction - 1) % 4
          new_cost = cost # + TURN_COST
     
          if new_cost < distances[x][y][new_dir]
            distances[x][y][new_dir] = new_cost
            p_queue << [new_cost, x, y, new_dir]
          end
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

end