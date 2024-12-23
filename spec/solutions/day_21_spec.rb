require "spec_helper"
require "solutions/day_21"

RSpec.describe Day21 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_21_test.txt')).strip }

  describe '#part_one' do
    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(126384)
    end
  end
end

