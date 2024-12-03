require 'spec_helper'
require 'solutions/day_03'

RSpec.describe Day03 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_03_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(161)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      expect(subject.part_two(input)).to eq(48)
    end
  end
end
