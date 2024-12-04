require 'spec_helper'
require 'solutions/day_04'

RSpec.describe Day04 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_04_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(18)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(9)
    end
  end
end
