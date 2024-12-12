require 'spec_helper'
require 'solutions/day_12'

RSpec.describe Day12 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_12_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(1930)
    end
  end

  describe '#part_two' do
    xit 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(1206)
    end
  end
end
