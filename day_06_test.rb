require 'minitest/autorun'
require_relative 'day_06'

class Day06Test < Minitest::Test
  def test__reads_input_file
    day_06 = Day06.new("data/day_06_input_test_1.txt")
    assert_equal("mjqjpqmgbljsphdztnvjfqwrcgsmlb", day_06.input)
  end

  def test__get_first_packet_end
    assert_equal(7, Day06.new("data/day_06_input_test_1.txt").get_first_packet_end)
    assert_equal(5, Day06.new("data/day_06_input_test_2.txt").get_first_packet_end)
    assert_equal(6, Day06.new("data/day_06_input_test_3.txt").get_first_packet_end)
    assert_equal(10, Day06.new("data/day_06_input_test_4.txt").get_first_packet_end)
    assert_equal(11, Day06.new("data/day_06_input_test_5.txt").get_first_packet_end)
  end

  def test__get_first_packet_start
    assert_equal(19, Day06.new("data/day_06_input_test_1.txt").get_first_packet_start)
    assert_equal(23, Day06.new("data/day_06_input_test_2.txt").get_first_packet_start)
    assert_equal(23, Day06.new("data/day_06_input_test_3.txt").get_first_packet_start)
    assert_equal(29, Day06.new("data/day_06_input_test_4.txt").get_first_packet_start)
    assert_equal(26, Day06.new("data/day_06_input_test_5.txt").get_first_packet_start)
  end

  def test__all_distinct
    assert_equal(true, Day06.all_distinct?(%w[a b c d]))

    assert_equal(false, Day06.all_distinct?(%w[a b c c]))
    assert_equal(false, Day06.all_distinct?(%w[a b c a]))
    assert_equal(false, Day06.all_distinct?(%w[a a a a]))
  end
end
