require 'spec_helper'
require 'solutions/day_10'

RSpec.describe Day10 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_10_test.txt')).strip }

  describe '#part_one' do
    it 'small example' do
      input = <<~INPUT
        0123
        1234
        8765
        9876
      INPUT
      expect(subject.part_one(input)).to eq(1)
    end

    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(36)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(81)
    end
  end
end
