require 'spec_helper'
require 'solutions/day_07'

RSpec.describe Day07 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_07_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(3749)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(0)
    end
  end
end
