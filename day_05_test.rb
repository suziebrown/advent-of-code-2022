require 'minitest/autorun'
require_relative 'day_05'

class Day05Test < Minitest::Test
  def test__reads_input_file
    day_05 = Day05.new("data/day_05_input_test.txt")

    assert_equal(4, day_05.moves.length)
    assert_equal(3, day_05.stacks.number_of_stacks)
    assert_equal([%w[Z N], %w[M C D], %w[P]], day_05.stacks.crates)
  end

  def test__apply_moves
    day_05 = Day05.new("data/day_05_input_test.txt")
    day_05.apply_moves
    assert_equal([%w[C], %w[M], %w[P D N Z]], day_05.stacks.crates)
  end

  def test__apply_moves_2
    day_05 = Day05.new("data/day_05_input_test.txt")
    day_05.apply_moves_2
    assert_equal([%w[M], %w[C], %w[P Z N D]], day_05.stacks.crates)
  end

  def test__get_top_crates
    day_05 = Day05.new("data/day_05_input_test.txt")
    assert_equal("NDP", day_05.get_top_crates)
  end

  def test__apply_moves_and_get_top_crates
    day_05 = Day05.new("data/day_05_input_test.txt")
    assert_equal("CMZ", day_05.apply_moves_and_get_top_crates)
  end

  def test__apply_moves_2_and_get_top_crates
    day_05 = Day05.new("data/day_05_input_test.txt")
    assert_equal("MCD", day_05.apply_moves_2_and_get_top_crates)
  end

  def test__get_crates_in_stack
    crates_0 = Stacks.get_crates_in_stack(0, ["[A] [B] [C]", "[D] [E]", "    [F]",])
    crates_1 = Stacks.get_crates_in_stack(1, ["[A] [B] [C]", "[D] [E]", "    [F]",])
    crates_2 = Stacks.get_crates_in_stack(2, ["[A] [B] [C]", "[D] [E]", "    [F]",])
    assert_equal(%w[A D], crates_0)
    assert_equal(%w[B E F], crates_1)
    assert_equal(%w[C], crates_2)
  end

  def test__apply_move
    day_05 = Day05.new("data/day_05_input_test.txt")

    day_05.stacks.apply_move("move 1 from 2 to 1")
    assert_equal([%w[Z N D], %w[M C], %w[P]], day_05.stacks.crates)

    day_05.stacks.apply_move("move 3 from 1 to 3")
    assert_equal([[], %w[M C], %w[P D N Z]], day_05.stacks.crates)

    day_05.stacks.apply_move("move 2 from 2 to 1")
    assert_equal([%w[C M], [], %w[P D N Z]], day_05.stacks.crates)

    day_05.stacks.apply_move("move 1 from 1 to 2")
    assert_equal([%w[C], %w[M], %w[P D N Z]], day_05.stacks.crates)
  end

  def test__apply_move_2
    day_05 = Day05.new("data/day_05_input_test.txt")

    day_05.stacks.apply_move_2("move 1 from 2 to 1")
    assert_equal([%w[Z N D], %w[M C], %w[P]], day_05.stacks.crates)

    day_05.stacks.apply_move_2("move 3 from 1 to 3")
    assert_equal([[], %w[M C], %w[P Z N D]], day_05.stacks.crates)

    day_05.stacks.apply_move_2("move 2 from 2 to 1")
    assert_equal([%w[M C], [], %w[P Z N D]], day_05.stacks.crates)

    day_05.stacks.apply_move_2("move 1 from 1 to 2")
    assert_equal([%w[M], %w[C], %w[P Z N D]], day_05.stacks.crates)
  end

  def test__parse_move_instruction
    assert_equal([1, 1, 0], Stacks.parse_move_instruction("move 1 from 2 to 1"))
    assert_equal([12, 8, 3], Stacks.parse_move_instruction("move 12 from 9 to 4"))
  end
end
