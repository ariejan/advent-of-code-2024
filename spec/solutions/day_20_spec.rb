require "spec_helper"
require "solutions/day_20"

RSpec.describe Day20 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_20_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      results = Day20::DayOne.new(input).run!

      expect(results[2]).to eq(14)
      expect(results[4]).to eq(14)
      expect(results[6]).to eq(2)
      expect(results[8]).to eq(4)
      expect(results[10]).to eq(2)
      expect(results[12]).to eq(3)
      expect(results[20]).to eq(1)
      expect(results[36]).to eq(1)
      expect(results[38]).to eq(1)
      expect(results[40]).to eq(1)
      expect(results[64]).to eq(1)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      results = Day20::DayTwo.new(input).run!

      expect(results[50]).to eq(32)
      expect(results[52]).to eq(31)
      expect(results[54]).to eq(29)
      expect(results[56]).to eq(39)
      expect(results[58]).to eq(25)
      expect(results[60]).to eq(23)
      expect(results[62]).to eq(20)
      expect(results[64]).to eq(19)
      expect(results[66]).to eq(12)
      expect(results[68]).to eq(14)
      expect(results[70]).to eq(12)
      expect(results[72]).to eq(22)
      expect(results[74]).to eq(4)
      expect(results[76]).to eq(3)
    end
  end
end

