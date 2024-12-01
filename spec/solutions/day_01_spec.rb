require 'spec_helper'
require 'solutions/day_01'

RSpec.describe Day01 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_01_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(11)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(31)
    end
  end
end
