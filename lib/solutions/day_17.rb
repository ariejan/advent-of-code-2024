class Day17 
  def part_one(input)
    lines = input.split("\n")
    ra = lines[0].scan(/Register A: (\d+)/).first.first.to_i
    rb = lines[1].scan(/Register B: (\d+)/).first.first.to_i
    rc = lines[2].scan(/Register C: (\d+)/).first.first.to_i
    instructions = lines[4].split(":").last.split(",").map(&:to_i)

    cpu = Cpu.new(ra, rb, rc, instructions)
    output = cpu.run

    output
  end

  def part_two(input)
    0
  end
end

class Cpu
  attr_accessor :ra, :rb, :rc
  attr_accessor :ip
  attr_accessor :instructions
  attr_accessor :output

  OPCODES = {
    0 => "adv",
    1 => "bxl",
    2 => "bst",
    3 => "jnz",
    4 => "bxc",
    5 => "out",
    6 => "bdv",
    7 => "cdv"
  }.freeze

  OPERANDS = {
    0 => 0,
    1 => 1,
    2 => 2,
    3 => 3,
    4 => "ra",
    5 => "rb",
    6 => "rc",
    7 => nil
  }

  def initialize(ra, rb, rc, instructions = [])
    @ra = ra
    @rb = rb
    @rc = rc
    @ip = 0
    @instructions = instructions
    @output = []
  end

  def run 
    while @ip < @instructions.size
      step
      puts to_s
    end
    @output.map(&:to_s).join(',')
  end

  # Single CPU cycle
  def step
    opcode, literal, combo = read_instruction

    puts "Opcode: #{opcode}, Literal: #{literal}, Combo: #{combo}"

    case opcode
    when "adv"
      @ra = (@ra.to_f / (2.0 ** combo.to_f)).truncate
    when "bdv"
      @rb = (@ra.to_f / (2.0 ** combo.to_f)).truncate
    when "cdv"
      @rc = (@ra.to_f / (2.0 ** combo.to_f)).truncate
    when "bxl"
      @rb = @rb ^ literal
    when "bst"
      @rb = combo % 8
    when "jnz"
      if @ra != 0
        # This 'undoes' the ip increment from read_instructions
        @ip = literal
      end
    when "bxc"
      @rb = @rb ^ @rc
    when "out"
      @output << (combo % 8)
    else
      puts "Unknown opcode: #{opcode}"
    end
  end

  def read_instruction
    raw_opcode = @instructions[@ip]
    opcode = OPCODES[raw_opcode]

    literal = @instructions[@ip + 1]

    combo = OPERANDS[literal]
    if combo.is_a?(String)
      combo = instance_variable_get("@#{combo}")
    end
    
    @ip += 2

    return [opcode, literal, combo]
  end

  def to_s
    puts "RA: #{@ra}, RB: #{@rb}, RC: #{@rc}"
    puts "IP: #{@ip}"
    puts "Instructions: #{@instructions}"
    puts "            " + " " * @ip * 3 + "^"
    puts "Output: #{@output}"
  end
end

