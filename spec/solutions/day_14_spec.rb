require 'spec_helper'
require 'solutions/day_14'

RSpec.describe Day14 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_14_test.txt')).strip }

  describe '#part_one' do
    it 'bot has px,xy' do
      bot = Robot.new(1, 2, 3, 4, 5, 6)
      expect(bot.p).to eq([1, 2])
    end

    it 'bot can move' do
      bot = Robot.new(0, 0, 1, 2, 5, 5)
      expect(bot.p).to eq([0, 0])
      bot.move!
      expect(bot.p).to eq([1, 2])
    end

    it 'bot can wrpa around' do
      bot = Robot.new(0, 0, 1, 5, 3, 3)
      expect(bot.p).to eq([0, 0])
      bot.move!
      expect(bot.p).to eq([1, 2])
    end

    it 'bot can doe multiple moves with wrap around' do
      bot = Robot.new(0, 0, 1, 1, 3, 3)
      expect(bot.p).to eq([0, 0])
      bot.move!(5)
      expect(bot.p).to eq([2, 2])
    end

    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input, 11, 7)).to eq(12)
    end
  end
end
