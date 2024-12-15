class Day15
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
    0
  end
end
