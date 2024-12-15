require 'spec_helper'
require 'solutions/day_15'

RSpec.describe Day15 do
  let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_15_test.txt')).strip }

  describe '#part_one' do
    context 'small test' do
      let(:input) { File.read(File.join(__dir__, '..', '..', 'spec', 'input', 'day_15_small_test.txt')).strip }

      it 'calculates the correct solutions for part one' do
        expect(subject.part_one(input)).to eq(2028)
      end

      it 'outputs the correct map' do
        sim = Day15::PartOne.new(input)
        sim.run!
        expect(sim.to_map).to eq(final_small)
      end

      it 'step 2' do
        sim = Day15::PartOne.new(step2)
        sim.step!('^')
        expect(sim.to_map).to eq(step3)
      end

      it 'step 3' do
        sim = Day15::PartOne.new(step3)
        sim.step!('^')
        expect(sim.to_map).to eq(step4)
      end

      it 'step 4' do
        sim = Day15::PartOne.new(step4)
        sim.step!('>')
        expect(sim.to_map).to eq(step5)
      end

      it 'step 5' do
        sim = Day15::PartOne.new(step5)
        sim.step!('>')
        expect(sim.to_map).to eq(step6)
      end

      it 'step 6' do
        sim = Day15::PartOne.new(step6)
        sim.step!('>')
        expect(sim.to_map).to eq(step7)
      end

      it 'step 7' do
        sim = Day15::PartOne.new(step7)
        sim.step!('v')
        expect(sim.to_map).to eq(step8)
      end

      it 'step 8' do
        sim = Day15::PartOne.new(step8)
        sim.step!('v')
        expect(sim.to_map).to eq(step9)
      end

      it 'step 9' do
        sim = Day15::PartOne.new(step9)
        sim.step!('<')
        expect(sim.to_map).to eq(step10)
      end

      it 'step 10' do
        sim = Day15::PartOne.new(step10)
        sim.step!('v')
        expect(sim.to_map).to eq(step11)
      end

      it 'step 11' do
        sim = Day15::PartOne.new(step11)
        sim.step!('>')
        expect(sim.to_map).to eq(step12)
      end

      it 'step 12' do
        sim = Day15::PartOne.new(step12)
        sim.step!('>')
        expect(sim.to_map).to eq(step13)
      end

      it 'step 13' do
        sim = Day15::PartOne.new(step13)
        sim.step!('v')
        expect(sim.to_map).to eq(step14)
      end

      it 'step 14' do
        sim = Day15::PartOne.new(step14)
        sim.step!('<')
        expect(sim.to_map).to eq(step15)
      end

      it 'step 15' do
        sim = Day15::PartOne.new(step15)
        sim.step!('<')
        expect(sim.to_map).to eq(step16)
      end
    end

    it 'calculates the correct solutions for part one' do
      expect(subject.part_one(input)).to eq(10_092)
    end
  end

  describe '#part_two' do
    it 'calculates the correct solutions for part two' do
      expect(subject.part_two(input)).to eq(0)
    end
  end

  let(:step1) do
    <<~MAP
      ########
      #..O.O.#
      ##@.O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########
    MAP
  end

  let(:step2) do
    <<~MAP
      ########
      #..O.O.#
      ##@.O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########
    MAP
  end

  let(:step3) do
    <<~MAP
      ########
      #.@O.O.#
      ##..O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########
    MAP
  end

  let(:step4) do
    <<~MAP
      ########
      #.@O.O.#
      ##..O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########
    MAP
  end

  let(:step5) do
    <<~MAP
      ########
      #..@OO.#
      ##..O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########
    MAP
  end

  let(:step6) do
    <<~MAP
      ########
      #...@OO#
      ##..O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########
    MAP
  end

  let(:step7) do
    <<~MAP
      ########
      #...@OO#
      ##..O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########
    MAP
  end

  let(:step8) do
    <<~MAP
      ########
      #....OO#
      ##..@..#
      #...O..#
      #.#.O..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step9) do
    <<~MAP
      ########
      #....OO#
      ##..@..#
      #...O..#
      #.#.O..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step10) do
    <<~MAP
      ########
      #....OO#
      ##.@...#
      #...O..#
      #.#.O..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step11) do
    <<~MAP
      ########
      #....OO#
      ##.....#
      #..@O..#
      #.#.O..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step12) do
    <<~MAP
      ########
      #....OO#
      ##.....#
      #...@O.#
      #.#.O..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step13) do
    <<~MAP
      ########
      #....OO#
      ##.....#
      #....@O#
      #.#.O..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step14) do
    <<~MAP
      ########
      #....OO#
      ##.....#
      #.....O#
      #.#.O@.#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step15) do
    <<~MAP
      ########
      #....OO#
      ##.....#
      #.....O#
      #.#O@..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:step16) do
    <<~MAP
      ########
      #....OO#
      ##.....#
      #.....O#
      #.#O@..#
      #...O..#
      #...O..#
      ########
    MAP
  end

  let(:final_small) do
    <<~MAP
      ########
      #....OO#
      ##.....#
      #.....O#
      #.#O@..#
      #...O..#
      #...O..#
      ########
    MAP
  end
end
