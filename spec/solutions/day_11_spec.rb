require 'spec_helper'
require 'solutions/day_11'

RSpec.describe Day11 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_11_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(55_312)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(0)
    end
  end
end
