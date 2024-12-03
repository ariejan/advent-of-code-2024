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
      expect(subject.part_two(input)).to eq(0)
    end
  end
end
