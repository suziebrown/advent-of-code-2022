require 'minitest/autorun'
require_relative 'day_05'

class Day05Test < Minitest::Test
  def test__reads_input_file
    day_05 = Day05.new("data/day_05_input_test.txt")

    assert_equal(4, day_05.moves.length)
  end
end
