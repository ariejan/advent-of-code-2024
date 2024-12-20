class Day20 
  def part_one(input)
    sim = DayOne.new(input)
    results = sim.run!

    top_results = results.select { |k,v| k >= 100 }
    top_results.values.sum
  end

  def part_two(input)
    sim = DayTwo.new(input)
    results = sim.run!

    top_results = results.select { |k,v| k >= 100 }
    top_results.values.sum
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

    def initialize(input)
      @grid = input.split("\n")
      @cols = @grid[0].size
      @rows = @grid.size

      @start = find_cell('S')
      @finish = find_cell('E')
    end

    def to_s
      @grid.map { |r| r.join('') }
    end

    def n_step_reachable(x, y, n = 2)
      result = []
      first_step = neighbours(x, y)
      first_step.each do |dx, dy|
        second_step = neighbours(dx, dy)
        second_step.each do |ddx, ddy|
          ## ddx,ddy is reachable in 2 steps
          result << [ddx, ddy] if @grid[ddy][ddx] != '#'
        end
      end
      result
    end

    def run!
      distances_start = bfs_distances(@start)
      distances_finish = bfs_distances(@finish)

      normal_time = distances_start[@finish[1]][@finish[0]]
      return 0 if normal_time == Float::INFINITY

      # Get only cells that are reachable from both start and finish
      valid_cells = []
      # puts @grid.inspect
      (0...@rows).each do |y|
        (0...@cols).each do |x|
          next if @grid[y][x] == '#'
          if distances_start[y][x] != Float::INFINITY && distances_finish[y][x] != Float::INFINITY
            valid_cells << [x, y]
          end
        end
      end

      # Index cells by row to speed lookups:
      valid_cells.sort_by!{|x,y| [x,y]}
      by_row = Hash.new{|h,k| h[k]=[]}
      valid_cells.each{|x,y| by_row[y] << [x,y]}

      max_distance = 20
      savings_count = Hash.new(0)

      valid_cells.each do |x, y|
        da = distances_start[y][x] 
        
        # Limit range of rows
        min_y = [0, y - max_distance].max
        max_y = [@rows - 1, y + max_distance].min

        (min_y..max_y).each do |ry|
          by_row[ry].each do |dx, dy|
            m_dist = (x - dx).abs + (y - dy).abs
            next if m_dist > max_distance
            db = distances_finish[dy][dx]

            cheat_time = da + m_dist + db
            savings = normal_time - cheat_time
            if savings > savings_count[[x,y,dx,dy]]
              savings_count[savings] += 1 if savings > 0
            end
          end
        end
      end

      # puts savings_count.inspect
      savings_count
    end

    def neighbours(x, y)
      [[x-1,y],[x+1,y],[x,y-1],[x,y+1]].select { |nx,ny| nx >= 0 && nx < @cols && ny >= 0 && ny < @rows }
    end

    def bfs_distances(start)
      distances = Array.new(@rows) { Array.new(@cols, Float::INFINITY) }
      distances[start[1]][start[0]] = 0
      queue = [start]

      head = 0
      while head < queue.size
        x, y = queue[head]
        head += 1

        neighbours(x, y).each do |dx, dy|
          next if @grid[dy][dx] == '#'
          next if distances[dy][dx] < Float::INFINITY

          distances[dy][dx] = distances[y][x] + 1
          queue << [dx, dy]
        end
      end

      distances
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

    def initialize(input)
      @grid = input.split("\n")
      @cols = @grid.size
      @rows = @grid[0].size

      @start = find_cell('S')
      @finish = find_cell('E')
    end

    def to_s
      @grid.map { |r| r.join('') }
    end

    def two_step_reachable(x, y)
      result = []
      first_step = neighbours(x, y)
      first_step.each do |dx, dy|
        second_step = neighbours(dx, dy)
        second_step.each do |ddx, ddy|
          ## ddx,ddy is reachable in 2 steps
          result << [ddx, ddy] if @grid[ddy][ddx] != '#'
        end
      end
      result
    end

    def run!
      distances_start = bfs_distances(@start)
      distances_finish = bfs_distances(@finish)

      normal_time = distances_start[@finish[1]][@finish[0]]
      return 0 if normal_time == Float::INFINITY

      savings_count = Hash.new(0)

      (0...@rows).each do |y|
        (0...@cols).each do |x|
          next if @grid[y][x] == '#'

          da = distances_start[y][x] 
          next if da == Float::INFINITY

          two_step_reachable(x, y).each do |dx, dy|
            db = distances_finish[dy][dx]
            next if db == Float::INFINITY
            cheat_time = da + 2 + db
            savings = normal_time - cheat_time
            if savings > 0
              savings_count[savings] += 1
            end
          end
        end
      end

      savings_count
    end

    def neighbours(x, y)
      [[x-1,y],[x+1,y],[x,y-1],[x,y+1]].select { |nx,ny| nx >= 0 && nx < @cols && ny >= 0 && ny < @rows }
    end

    def bfs_distances(start)
      distances = Array.new(@rows) { Array.new(@cols, Float::INFINITY) }
      distances[start[1]][start[0]] = 0
      queue = [start]

      head = 0
      while head < queue.size
        x, y = queue[head]
        head += 1

        neighbours(x, y).each do |dx, dy|
          next if @grid[dy][dx] == '#'
          next if distances[dy][dx] < Float::INFINITY

          distances[dy][dx] = distances[y][x] + 1
          queue << [dx, dy]
        end
      end

      distances
    end



    def find_path
    #   # Run, Dijkstra, Run!
    #   start_xy = [0,0]
    #   end_xy = [@cols - 1, @rows - 1]

    #   direction = 1 # East

    #   # 3D array to keep track of distances from each cell
    #   distances = Array.new(@cols) { Array.new(@rows) { Array.new(4, Float::INFINITY) } }
      
    #   # Start cell
    #   distances[start_xy[0]][start_xy[1]][direction] = 0

    #   # Priority queue for [cost, x, y, direction]
    #   p_queue = []
    #   p_queue << [0, start_xy[0], start_xy[1], direction]

    #   while !p_queue.empty?
    #     # Sort priority queueu by cost
    #     p_queue.sort_by! { |a| a[0] }

    #     # Get next items from queue
    #     cost, x, y, direction = p_queue.shift

    #     # Reached end
    #     return cost if x == end_xy[0] && y == end_xy[1]

    #     # Skip if we already have a lower cost to this cell
    #     next if distances[x][y][direction] < cost

    #     # Try moving forward
    #     new_x = x + DIRECTIONS[direction][0]
    #     new_y = y + DIRECTIONS[direction][1]

    #     if can_move?(new_x, new_y)
    #       new_cost = cost + MOVE_COST
    #       if new_cost < distances[new_x][new_y][direction]
    #         distances[new_x][new_y][direction] = new_cost
    #         p_queue << [new_cost, new_x, new_y, direction]
    #       end
    #     end

    #     # Try turning
    #     [
    #       direction, 
    #       (direction + 1) % 4, 
    #       (direction + 2) % 4, 
    #       (direction + 3) % 4
    #     ].each do |new_dir|
    #       new_dir = (direction - 1) % 4
    #       new_cost = cost # + TURN_COST
     
    #       if new_cost < distances[x][y][new_dir]
    #         distances[x][y][new_dir] = new_cost
    #         p_queue << [new_cost, x, y, new_dir]
    #       end
    #     end
    
    #   end

    #   # Can't move forward...
    #   return Float::INFINITY
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

