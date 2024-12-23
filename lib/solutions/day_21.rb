require 'set'

class Day21

  def part_one(input)
    sequences = input.split("\n")
    sim = DayOne.new(sequences)
    sim.run!
  end

  class DayOne

    def initialize(sequences)
      @sequences = sequences

      @moves_cache = {}
      @scores_cache = {}
    end

    # Define the numeric keypad with coordinates
    NUMPAD = {
      '7' => [0, 0],
      '8' => [0, 1],
      '9' => [0, 2],
      '4' => [1, 0],
      '5' => [1, 1],
      '6' => [1, 2],
      '1' => [2, 0],
      '2' => [2, 1],
      '3' => [2, 2],
      ' ' => [3, 0],
      '0' => [3, 1],
      'A' => [3, 2]
    }.freeze

    # Define the directional keypad movements with corresponding commands
    KEYPAD = {
      ' ' => [0, 0],
      '^' => [0, 1],
      'A' => [0, 2],
      '<' => [1, 0],
      'v' => [1, 1],
      '>' => [0, 2]
    }.freeze


    def xdir(x)
      x > 0 ? 'v' : '^'
    end

    def ydir(y)
      y > 0 ? '>' : '<'
    end

    def run!
      result = 0
      @sequences.each do |sequence|
        value = Float::INFINITY
        500.times do 
          @moves_cache.clear
          @scores_cache.clear
          value = [value, score(sequence, 3, 0) * sequence[0..-2].to_i].min
        end
        result += value
      end
      result
    end

    def score(sequence, depth, current = 0)
      cache_key = [sequence, depth, current]
      # puts "scores_cache: #{@scores_cache}"
      return @scores_cache[cache_key] if @scores_cache.key?(cache_key)

      return sequence.length if depth == 0

      total = current
      sequence.chars.each_with_index do |key, index|
        next_key = sequence[index - 1]
        total += score(moves(next_key, key), depth - 1)
      end

      @scores_cache[cache_key] = total
    end

    def moves(current_key, next_key)
      cache_key = [current_key, next_key]

      return @moves_cache[cache_key] if @moves_cache.key?(cache_key)  
  
      # Pick the pad given the current and next key
      pad = (KEYPAD.key?(current_key) && KEYPAD.key?(next_key)) ? KEYPAD : NUMPAD
      
      # puts "-" * 40
      # puts "current_key: #{current_key}, next_key: #{next_key}"
      # puts "#{KEYPAD.keys}"
      # puts "pad: #{pad}"
      # puts "pad[current_key]: #{pad[current_key]}, pad[next_key]: #{pad[next_key]}"
      # puts "-" * 40

      # Get x,y distances to move
      distance = [pad[next_key][0] - pad[current_key][0], pad[next_key][1] - pad[current_key][1]]
      # Map out key presses
      presses = xdir(distance[0]) * distance[0].abs + ydir(distance[1]) * distance[1].abs

      if pad[" "] == [pad[next_key][0], pad[current_key][1]]
        result =  presses.reverse + 'A'
      elsif pad[" "] == [pad[current_key][0], pad[next_key][1]]
        result = presses + 'A'
      else 
        result = (rand < 0.5 ? presses : presses.reverse) + 'A'
      end
      
      @moves_cache[cache_key] = result
    end
  end
end