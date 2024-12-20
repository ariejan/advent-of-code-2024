require "spec_helper"
require "solutions/day_20"

RSpec.describe Day20 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_20_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      results = subject.part_one(input)

      expect(results[2]).to eq(14)
      expect(results[4]).to eq(14)
      expect(results[6]).to eq(2)
      expect(results[8]).to eq(4)
      expect(results[10]).to eq(2)
      expect(results[12]).to eq(3)
      expect(results[20]).to eq(1)
      expect(results[36]).to eq(1)
      expect(results[38]).to eq(1)
      expect(results[40]).to eq(1)
      expect(results[64]).to eq(1)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(0)
    end
  end
end

