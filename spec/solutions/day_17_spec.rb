require "spec_helper"
require "solutions/day_17"

RSpec.describe Day17 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_17_test.txt')).strip }

  describe '#part_one' do
    it 'test 1' do
      cpu = Cpu.new(0, 0, 9, [2,6])
      cpu.run
      expect(cpu.rb).to eq(1)
    end

    it 'test 2' do
      cpu = Cpu.new(10, 0, 0, [5,0,5,1,5,4])
      cpu.run
      expect(cpu.output).to eq([0,1,2])
    end

    it 'test 3' do
      cpu = Cpu.new(2024, 0, 0, [0,1,5,4,3,0])
      cpu.run
      expect(cpu.output).to eq([4,2,5,6,7,7,7,7,3,1,0])
      expect(cpu.ra).to eq(0)
    end

    it 'test 4' do
      cpu = Cpu.new(0, 29, 0, [1,7])
      cpu.run
      expect(cpu.rb).to eq(26)
    end

    it 'test 5' do
      cpu = Cpu.new(0, 2024, 43690, [4,0])
      cpu.run
      expect(cpu.rb).to eq(44354)
    end

    it 'test bst' do
      # Mod 8 on B
      cpu = Cpu.new(0, 1980, 0, [2,5])
      cpu.run
      expect(cpu.rb).to eq(4)
    end
    
    it 'example' do
      cpu = Cpu.new(62769524, 0, 0, [2,4,1,7,7,5,0,3,4,0,1,7,5,5,3,0])
      result = cpu.run
      expect(result).not_to eql("214074023")
    end
    ## 

    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq("4,6,3,5,6,3,5,2,1,0")
    end
  end

  describe '#part_two' do
    xit 'calculates the correct solutions for part two' do
      cpu = Cpu.new(2024, 0, 0, [0,3,5,4,3,0])
      result = cpu.run
      expect(result).not_to eql(117440)
    end
  end
end

