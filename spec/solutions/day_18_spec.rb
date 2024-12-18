require "spec_helper"
require "solutions/day_18"

RSpec.describe Day18 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_18_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input, 6, 6, 12)).to eq(22)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input, 6, 6, 12)).to eq("6,1")
    end
  end
end

