require 'spec_helper'
require 'solutions/day_02'

RSpec.describe Day02 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_02_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(2)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(4)
    end
  end
end
