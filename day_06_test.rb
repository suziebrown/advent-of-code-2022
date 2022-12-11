require 'minitest/autorun'
require_relative 'day_06'

class Day06Test < Minitest::Test
  def test__reads_input_file
    day_06 = Day06.new("data/day_06_input_test_1.txt")
    assert_equal("mjqjpqmgbljsphdztnvjfqwrcgsmlb", day_06.input)
  end

  def test__find_first_packet_end
    assert_equal(7, Day06.new("data/day_06_input_test_1.txt").get_first_packet_end)
    assert_equal(5, Day06.new("data/day_06_input_test_2.txt").get_first_packet_end)
    assert_equal(6, Day06.new("data/day_06_input_test_3.txt").get_first_packet_end)
    assert_equal(10, Day06.new("data/day_06_input_test_4.txt").get_first_packet_end)
    assert_equal(11, Day06.new("data/day_06_input_test_5.txt").get_first_packet_end)
  end

  def test__update_tally
    day_06 = Day06.new("data/day_06_input_test_1.txt")
    day_06.last_four_characters_tally = Hash.new({ "a" => 0, "b" => 1, "c" => 2, "d" => 1 })

    day_06.update_tally("b", "d")
    assert_equal(0, day_06.last_four_characters_tally["a"])
    assert_equal({ "a" => 0, "b" => 2, "c" => 2, "d" => 0 }, day_06.last_four_characters_tally)
  end

  def test__packet_end
    assert_equal(true, Day06.packet_end?(Hash.new({ "a" => 1, "b" => 1, "c" => 1, "d" => 1 })))
  end
end
