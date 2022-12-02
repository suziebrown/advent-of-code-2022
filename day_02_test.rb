require 'minitest/autorun'
require_relative 'day_02'

class Day02Test < Minitest::Test
  def test__reads_input_file
    day_02 = Day02.new("data/day_02_input_test.txt")
    assert_equal(3, day_02.input.length)
  end

  def test__get_outcome_score
    round = Round.new("A X")

    round.their_move = "A"
    round.my_move = "Y"
    assert_equal(6, round.get_outcome_score)

    round.their_move = "B"
    round.my_move = "X"
    assert_equal(0, round.get_outcome_score)

    round.their_move = "C"
    round.my_move = "Z"
    assert_equal(3, round.get_outcome_score)
  end

  def test__get_shape_score
    round = Round.new("A X")

    round.my_move = "X"
    assert_equal(1, round.get_shape_score)

    round.my_move = "Y"
    assert_equal(2, round.get_shape_score)

    round.my_move = "Z"
    assert_equal(3, round.get_shape_score)
  end

  def test__get_total_score_for_round
    day_02 = Day02.new("data/day_02_input_test.txt")
    assert_equal(8, Round.new(day_02.input[0]).get_total_score_for_round)
    assert_equal(1, Round.new(day_02.input[1]).get_total_score_for_round)
    assert_equal(6, Round.new(day_02.input[2]).get_total_score_for_round)
  end

  def test__get_total_score_for_round_2
    day_02 = Day02.new("data/day_02_input_test.txt")
    assert_equal(4, Round.new(day_02.input[0]).get_total_score_for_round_2)
    assert_equal(1, Round.new(day_02.input[1]).get_total_score_for_round_2)
    assert_equal(7, Round.new(day_02.input[2]).get_total_score_for_round_2)
  end

  def test__calculate_total_score
    day_02 = Day02.new("data/day_02_input_test.txt")
    assert_equal(15, day_02.total_score)
  end

  def test__calculate_total_score_2
    day_02 = Day02.new("data/day_02_input_test.txt")
    assert_equal(12, day_02.total_score_2)
  end
end
