require 'minitest/autorun'
require_relative 'day_04'

class Day04Test < Minitest::Test
  def test__reads_input_file
    day_04 = Day04.new("data/day_04_input_test.txt")

    assert_equal(6, day_04.pairs.length)

    assert_equal(3, day_04.pairs[0].site_1.length)
    assert_equal(2, day_04.pairs[0].site_1[0])

    assert_equal(7, day_04.pairs[3].site_1.length)
    assert_equal(2, day_04.pairs[3].site_1[0])
  end

  def test__get_number_of_pairs_with_fully_containing
    day_04 = Day04.new("data/day_04_input_test.txt")
    assert_equal(2, day_04.get_number_of_pairs_with_fully_containing)
  end

  def test__get_number_of_pairs_with_any_overlap
    day_04 = Day04.new("data/day_04_input_test.txt")
    assert_equal(4, day_04.get_number_of_pairs_with_any_overlap)
  end

  def test__one_of_pair_fully_contained
    assert(!Pair.new("1-2,3-4").one_of_pair_fully_contained?)
    assert(!Pair.new("1-3,2-4").one_of_pair_fully_contained?)
    assert(!Pair.new("11-13,12-145").one_of_pair_fully_contained?)

    assert(Pair.new("1-4,2-4").one_of_pair_fully_contained?)
    assert(Pair.new("1-4,1-2").one_of_pair_fully_contained?)
    assert(Pair.new("1-4,1-4").one_of_pair_fully_contained?)
    assert(Pair.new("2-3,1-4").one_of_pair_fully_contained?)
    assert(Pair.new("12-13,12-145").one_of_pair_fully_contained?)
  end

  def test__has_any_overlap
    assert(!Pair.new("1-2, 3-4").has_any_overlap?)
    assert(!Pair.new("11-12, 13-145").has_any_overlap?)

    assert(Pair.new("1-2, 2-4").has_any_overlap?)
    assert(Pair.new("12-13, 13-145").has_any_overlap?)
  end
end
