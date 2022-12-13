require 'minitest/autorun'
require_relative 'day_08'

class Day08Test < Minitest::Test
  def test__reads_input_file
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(5, day_08.number_of_rows)
    assert_equal(5, day_08.number_of_columns)
    assert_equal(3, day_08.trees[0][0])
  end

  def test__get_number_of_visible_trees
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(21, day_08.get_number_of_visible_trees)
  end

  def test__get_highest_scenic_score
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(8, day_08.get_highest_scenic_score)
  end

  def test__get_number_of_trees_on_perimeter
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(16, day_08.get_number_of_trees_on_perimeter)
  end

  def test__get_number_of_visible_interior_trees
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(5, day_08.test__get_number_of_visible_interior_trees)
  end

  def test__tree_visible__tree_is_on_perimeter
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(true, day_08.tree_visible?(0,2))
    assert_equal(true, day_08.tree_visible?(4,2))
    assert_equal(true, day_08.tree_visible?(2,0))
    assert_equal(true, day_08.tree_visible?(2,4))
  end

  def test__tree_visible__tree_is_not_on_perimeter
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(true, day_08.tree_visible?(2,1))
    assert_equal(true, day_08.tree_visible?(1,2))
    assert_equal(true, day_08.tree_visible?(2,3))

    assert_equal(false, day_08.tree_visible?(3,1))
    assert_equal(false, day_08.tree_visible?(3,3))
    assert_equal(false, day_08.tree_visible?(1,3))
  end

  def test__tree_visible_from_left?
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(true, day_08.tree_visible_from_left?(1, 1))
    assert_equal(false, day_08.tree_visible_from_left?(3, 1))
  end

  def test__tree_visible_from_right?
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(true, day_08.tree_visible_from_right?(2, 3))
    assert_equal(false, day_08.tree_visible_from_right?(1, 3))
  end

  def test__tree_visible_from_top?
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(true, day_08.tree_visible_from_top?(1, 1))
    assert_equal(false, day_08.tree_visible_from_top?(2, 2))
  end

  def test__tree_visible_from_bottom?
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(true, day_08.tree_visible_from_bottom?(3, 2))
    assert_equal(false, day_08.tree_visible_from_bottom?(3, 3))
  end

  def test__get_scenic_score__tree_is_on_perimeter
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(0, day_08.get_scenic_score(0,2))
    assert_equal(0, day_08.get_scenic_score(4,2))
    assert_equal(0, day_08.get_scenic_score(2,0))
    assert_equal(0, day_08.get_scenic_score(2,4))
  end

  def test__get_scenic_score__tree_is_not_on_perimeter
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(4, day_08.get_scenic_score(1,2))
    assert_equal(8, day_08.get_scenic_score(3,2))
  end

  def test__get_viewing_distance_left
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(1, day_08.get_viewing_distance_left(1, 2))
  end

  def test__get_viewing_distance_right
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(2, day_08.get_viewing_distance_right(1, 2))
  end

  def test__get_viewing_distance_top
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(1, day_08.get_viewing_distance_top(1, 2))
  end

  def test__get_viewing_distance_bottom
    day_08 = Day08.new("data/day_08_input_test.txt")
    assert_equal(2, day_08.get_viewing_distance_bottom(1, 2))
  end

  def test__get_viewing_distance_for_line_of_trees
    assert_equal(0, Day08.get_viewing_distance_for_line_of_trees(5, []))
    assert_equal(3, Day08.get_viewing_distance_for_line_of_trees(5, [1, 2, 3]))
    assert_equal(2, Day08.get_viewing_distance_for_line_of_trees(5, [1, 6, 3]))
    assert_equal(3, Day08.get_viewing_distance_for_line_of_trees(5, [3, 2, 1]))
    assert_equal(1, Day08.get_viewing_distance_for_line_of_trees(5, [5, 1, 2]))
  end
end
