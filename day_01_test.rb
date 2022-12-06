require 'minitest/autorun'
require_relative 'day_01'

class Day01Test < Minitest::Test
  def test__reads_input_file
    day_01 = Day01.new("data/day_01_input_test.txt")
    assert_equal(1000, day_01.items_by_elf[0][0])
    assert_equal(5, day_01.number_of_elves)
  end

  def test__calculates_calories_per_elf
    day_01 = Day01.new("data/day_01_input_test.txt")
    assert_equal(6000, day_01.calories_per_elf[0])
  end

  def test__calculates_maximum_calories
    day_01 = Day01.new("data/day_01_input_test.txt")
    assert_equal(24000, day_01.get_maximum_calories)
  end

  def test__calculates_top_three_total_calories
    day_01 = Day01.new("data/day_01_input_test.txt")
    assert_equal(45000, day_01.get_top_three_total_calories)
  end
end
