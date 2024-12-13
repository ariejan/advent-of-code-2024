require 'spec_helper'
require 'solutions/day_13'

RSpec.describe Day13 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_13_test.txt')).strip }

  describe '#part_one' do
    it 'calculates machine 1' do
      m = ClawMachine.new(94, 34, 22, 67, 8400, 5400, 100)
      expect(m.solve!).to eq([280, 80, 40])
    end

    it 'calculates machine 2' do
      m = ClawMachine.new(26, 66, 67, 21, 12_748, 12_176, 100)
      expect(m.solve!).to be_nil
    end

    it 'calculates machine 3' do
      m = ClawMachine.new(17, 86, 84, 37, 7870, 6450, 100)
      expect(m.solve!).to eq([200, 38, 86])
    end

    it 'calculates machine 2' do
      m = ClawMachine.new(69, 23, 27, 71, 18_641, 10_279, 100)
      expect(m.solve!).to be_nil
    end

    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(480)
    end
  end

  describe '#part_two' do
    it 'calculates machine 1' do
      m = ClawMachine.new(94, 34, 22, 67, 10_000_000_008_400, 10_000_000_005_400)
      expect(m.solve!).to be_nil
    end

    it 'calculates machine 2' do
      m = ClawMachine.new(26, 66, 67, 21, 10_000_000_012_748, 10_000_000_012_176)
      expect(m.solve!).not_to be_nil
    end

    it 'calculates machine 3' do
      m = ClawMachine.new(17, 86, 84, 37, 10_000_000_007_870, 10_000_000_006_450)
      expect(m.solve!).to be_nil
    end

    it 'calculates machine 2' do
      m = ClawMachine.new(69, 23, 27, 71, 10_000_000_018_641, 10_000_000_010_279)
      expect(m.solve!).not_to be_nil
    end
  end
end
