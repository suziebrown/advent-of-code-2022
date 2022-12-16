require 'minitest/autorun'
require_relative 'day_09'

class Day09Test < Minitest::Test
  def test__reads_input_file
    day_09 = Day09.new("data/day_09_input_test.txt")
    assert_equal(8, day_09.head_moves.length)
    assert_equal(1, day_09.positions_visited_by_tail.length)
  end

  def test__get_number_of_positions_visited_by_tail
    day_09 = Day09.new("data/day_09_input_test.txt")
    assert_equal(13, day_09.get_number_of_positions_visited_by_tail)
  end

  def test__apply_all_moves
    day_09 = Day09.new("data/day_09_input_test.txt")
    day_09.apply_all_moves

    assert_equal(2, day_09.head_position.x)
    assert_equal(2, day_09.head_position.y)
    assert_equal(1, day_09.tail_position.x)
    assert_equal(2, day_09.tail_position.y)

    assert_equal(13, day_09.positions_visited_by_tail.length)
  end

  def test__apply_move
    day_09 = Day09.new("data/day_09_input_test.txt")
    assert_equal(1, day_09.positions_visited_by_tail.length)

    day_09.apply_move('R 2')
    assert_equal(2, day_09.head_position.x)
    assert_equal(0, day_09.head_position.y)
    assert_equal(1, day_09.tail_position.x)
    assert_equal(0, day_09.tail_position.y)
    assert_equal(2, day_09.positions_visited_by_tail.length)

    day_09.apply_move('D 3')
    assert_equal(2, day_09.head_position.x)
    assert_equal(-3, day_09.head_position.y)
    assert_equal(2, day_09.tail_position.x)
    assert_equal(-2, day_09.tail_position.y)
    assert_equal(4, day_09.positions_visited_by_tail.length)

    day_09.apply_move('U 1')
    assert_equal(2, day_09.head_position.x)
    assert_equal(-2, day_09.head_position.y)
    assert_equal(2, day_09.tail_position.x)
    assert_equal(-2, day_09.tail_position.y)
    assert_equal(4, day_09.positions_visited_by_tail.length)

    day_09.apply_move('L 100')
    assert_equal(-98, day_09.head_position.x)
    assert_equal(-2, day_09.head_position.y)
    assert_equal(-97, day_09.tail_position.x)
    assert_equal(-2, day_09.tail_position.y)
    assert_equal(103, day_09.positions_visited_by_tail.length)
  end

  def test__position__move_one_step
    position = Position.new(0, 0)
    assert_equal(0, position.x)
    assert_equal(0, position.y)

    position.move_one_step('R')
    assert_equal(1, position.x)
    assert_equal(0, position.y)

    position.move_one_step('D')
    assert_equal(1, position.x)
    assert_equal(-1, position.y)
  end

  def test__position__is_touching
    pos = Position.new(0, 0)
    assert_equal(true, pos.is_touching(Position.new(0, 1)))
    assert_equal(true, pos.is_touching(Position.new(1, 1)))
    assert_equal(true, pos.is_touching(Position.new(-1, 1)))
    assert_equal(true, pos.is_touching(Position.new(0, 0)))

    assert_equal(false, pos.is_touching(Position.new(0, 2)))
    assert_equal(false, pos.is_touching(Position.new(2, 2)))
  end
end
