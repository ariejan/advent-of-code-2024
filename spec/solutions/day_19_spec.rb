require "spec_helper"
require "solutions/day_19"

RSpec.describe Day19 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_19_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(6)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(0)
    end
  end
end

