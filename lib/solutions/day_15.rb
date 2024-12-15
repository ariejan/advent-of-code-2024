class Day15
  class PartTwo
    # Anything on the map
    class Entity < Struct.new(:x, :y, :w, :h, :type)
      def move!(dir)
        self.x += dir[0]
        self.y += dir[1]
      end

      def at?(pos)
        pos[0] >= x && pos[0] < x + w && pos[1] == y
      end

      def targets(dir)
        # PLayers are simple, they move one square
        return [[x + dir[0], y + dir[1]]] if type == :player
        
        # Crates are more comlicated when they move.
        # Moving on x-axis
        # Target 1 square to the left or right of current position. Not that
        # crates have x, x+1 coordinates
        if dir[0] == -1
          # Moving left, check square next to us.
          [[x - 1, y]]
        elsif dir[0] == 1
          # Moving right, check two squares to the right
          [[x + 2, y]]
        elsif dir[1] != 0
          # Check two square above or below
          [[x, y + dir[1]], [x + 1, y + dir[1]]]
        end
      end
    end

    R_WALL = '##'.freeze
    R_CRATE = '[]'.freeze
    R_PLAYER = '@.'.freeze
    R_FREE = '..'.freeze

    MAP_REPLACEMENTS = {
      '#' => R_WALL,
      'O' => R_CRATE,
      '@' => R_PLAYER,
      '.' => R_FREE
    }

    def initialize(input)
      map_input, moves_input = input.split(/(?:^\r?\n)+/)

      # Moves might be nil during tests
      @moves = moves_input.nil? ? nil : moves_input.gsub(/\n/, '').chars

      # Load map extra wide
      @map = wide_map(map_input)
      @width = @map[0].length
      @height = @map.length

      load_entities

      # Not using the map after this, 
      @map = nil
    end

    def load_entities
      @entities = []
      @map.each_with_index do |row, y|
        x = 0
        while x < row.length
          case row[x, 2]
          when R_WALL
            width = 2
            while x + width < row.length && row[x + width, 2] == R_WALL
              width += 2
            end
            @entities << Entity.new(x, y, width, 1, :wall)
            x += width
          when R_CRATE
            @entities << Entity.new(x, y, 2, 1, :crate)
            x += 2
          when R_PLAYER
            # Scan '@.', but ignore the free space
            @entities << Entity.new(x, y, 1, 1, :player)
            x += 2
          else
            x += 2
          end
        end
      end
    end

    def wide_map(map_input)
      @map = map_input.split("\n")
      @map.map do |row|
        row.gsub(/[#O.@]/, MAP_REPLACEMENTS)
      end
    end

    def run!
      @moves.each_with_index do |move, i|
        step!(move)
      end
    end

    def score
      @entities.select { |e| e.type == :crate }
        .map { |e| e.y * 100 + e.x }
        .sum
    end

    def step!(direction)
      dir = map_direction(direction)
      player = @entities.find { |e| e.type == :player }
      move!(player, dir)
    end

    # Move, 
    def move!(entity, dir)
      # puts "Moving #{entity.type} #{entity.x},#{entity.y} #{dir.inspect}"

      # Get list of target coords to check
      targets = entity.targets(dir)

      # puts targets.inspect

      entities = find_entities_at(targets)

      # puts entities.inspect

      # Can't move if we're hitting a wall
      return false if entities.any? { |e| e.type == :wall }

      # Free space
      # REMOVE: entities.all? { |e| e.move!(dir)} will return true for an 
      # empty array as well. 
      # if entities.none? 
      #   entity.move!(dir) 
      #   return true
      # end

      # Now free space, not a wall, so it must be one or two crates
      if entities.all? { |e| move!(e, dir)}
        entity.move!(dir)
        return true
      end
      
      false
    end

    def find_entities_at(coords)
      coords.map do |coord|
        @entities.find { |entity| entity.at?(coord) }
      end.compact.uniq
    end

    def move_cell(from, to)
      from_cell = get_cell(from)
      to_cell = get_cell(to)

      set_cell(from, to_cell)
      set_cell(to, from_cell)
    end

    def set_cell(pos, cell)
      @map[pos[1]][pos[0]] = cell
    end

    def get_cell(pos)
      return nil if pos[0] < 0 || pos[1] < 0 || pos[0] >= @map[0].length || pos[1] >= @map.length

      @map[pos[1]][pos[0]]
    end

    def map_direction(direction)
      case direction
      when '^'
        [0, -1]
      when 'v'
        [0, 1]
      when '<'
        [-1, 0]
      when '>'
        [1, 0]
      end
    end

    def to_map
      map = Array.new(@height) { Array.new(@width, '.') }
      @entities.each do |entity|
        case entity.type
        when :player
          map[entity.y][entity.x] = '@'
        when :crate
          map[entity.y][entity.x] = '['
          map[entity.y][entity.x + 1] = ']'
        when :wall
          entity.w.times do |x|
            map[entity.y][entity.x + x] = '#'
          end
        end
      end
      map.map(&:join).join("\n") + "\n"
    end
  end

  class PartOne
    WALL = '#'.freeze
    CRATE = 'O'.freeze
    PLAYER = '@'.freeze
    FREE = '.'.freeze

    def initialize(input)
      map_input, moves_input = input.split(/(?:^\r?\n)+/)

      # Moves might be nil during tests
      @moves = moves_input.nil? ? nil : moves_input.gsub(/\n/, '').chars

      @map = map_input.split("\n")

      # Find player
      find_player
    end

    def run!
      @moves.each_with_index do |move, i|
        step!(move)
      end
    end

    def score
      score = 0
      @map.each_with_index do |row, y|
        row.chars.each_with_index do |cell, x|
          score += (100 * y) + x if cell == CRATE
        end
      end
      score
    end

    def find_player
      @map.each_with_index do |row, y|
        row.chars.each_with_index do |cell, x|
          # TODO: Return when found.
          @player = [x, y] if cell == PLAYER
        end
      end
    end

    def step!(direction)
      dir = map_direction(direction)
      find_player

      move!(@player, dir)
    end

    def move!(from, dir)
      target = [from[0] + dir[0], from[1] + dir[1]]

      target_cell = get_cell(target)

      # Can't move through a wall
      return false if target_cell == WALL

      # Handle free move
      if target_cell == FREE
        move_cell(from, target)
        return true
      end

      # Move only if we can move whatever we're pushing
      if target_cell == CRATE && move!(target, dir)
        move_cell(from, target)
        return true
      end

      false
    end

    def move_cell(from, to)
      from_cell = get_cell(from)
      to_cell = get_cell(to)

      set_cell(from, to_cell)
      set_cell(to, from_cell)
    end

    def set_cell(pos, cell)
      @map[pos[1]][pos[0]] = cell
    end

    def get_cell(pos)
      return nil if pos[0] < 0 || pos[1] < 0 || pos[0] >= @map[0].length || pos[1] >= @map.length

      @map[pos[1]][pos[0]]
    end

    def map_direction(direction)
      case direction
      when '^'
        [0, -1]
      when 'v'
        [0, 1]
      when '<'
        [-1, 0]
      when '>'
        [1, 0]
      end
    end

    def to_map
      @map.join("\n") + "\n"
    end
  end

  def part_one(input)
    sim = PartOne.new(input)
    sim.run!
    sim.score
  end

  def part_two(input)
    sim = PartTwo.new(input)
    sim.run!
    sim.score
  end
end
