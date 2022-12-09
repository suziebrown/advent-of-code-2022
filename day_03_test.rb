require 'minitest/autorun'
require_relative 'day_03'

class Day03Test < Minitest::Test
  def test__reads_input_file
    day_03 = Day03.new("data/day_03_input_test.txt")
    assert_equal(6, day_03.rucksacks.length)
  end

  def test__get_item_priority__valid_item__returns_correct_priority
    assert_equal(16, Day03.get_item_priority("p"))
    assert_equal(38, Day03.get_item_priority("L"))
    assert_equal(42, Day03.get_item_priority("P"))
    assert_equal(22, Day03.get_item_priority("v"))
    assert_equal(20, Day03.get_item_priority("t"))
    assert_equal(19, Day03.get_item_priority("s"))

    assert_equal(1, Day03.get_item_priority("a"))
    assert_equal(26, Day03.get_item_priority("z"))
    assert_equal(27, Day03.get_item_priority("A"))
    assert_equal(52, Day03.get_item_priority("Z"))
  end

  def test__get_total_priority_of_rucksacks
    day_03 = Day03.new("data/day_03_input_test.txt")
    assert_equal(157, day_03.get_total_priority_of_rucksacks)
  end

  def test__get_total_priority_of_elf_groups
    day_03 = Day03.new("data/day_03_input_test.txt")
    assert_equal(70, day_03.get_total_priority_of_elf_groups)
  end

  def test__get_compartments
    rucksack = Rucksack.new("abCD")
    assert_equal(%w[a b], rucksack.compartment_1)
    assert_equal(%w[C D], rucksack.compartment_2)
  end

  def test__get_duplicated_item
    rucksack = Rucksack.new("abbCac")
    assert_equal("a", rucksack.get_duplicated_item)
  end

  def test__get_duplicated_item__no_duplicates__throws
    rucksack = Rucksack.new("abCA")

    assert_raises do
      rucksack.get_duplicated_item
    end
  end

  def test__get_duplicated_item__multiple_duplicates__throws
    rucksack = Rucksack.new("abba")

    assert_raises do
      rucksack.get_duplicated_item
    end
  end

  def test__get_item_priority__invalid_item__throws
    assert_raises do
      Day03.get_item_priority("aa")
    end
    assert_raises do
      Day03.get_item_priority("1")
    end
    assert_raises do
      Day03.get_item_priority("")
    end
  end

  def test__get_rucksack_priority_score
    rucksack = Rucksack.new("vJrwpWtwJgWrhcsFMMfFFhFp")
    assert_equal(16, rucksack.get_rucksack_priority_score)
  end

  def test__get_elf_groups
    day_03 = Day03.new("data/day_03_input_test.txt")
    elf_groups = day_03.elf_groups

    assert_equal(2, elf_groups.length)
    assert_equal("v", elf_groups[0].elf_1[0])
    assert_equal("w", elf_groups[1].elf_1[0])
  end

  def test__get_common_item
    day_03 = Day03.new("data/day_03_input_test.txt")
    elf_groups = day_03.elf_groups

    assert_equal("r", elf_groups[0].get_common_item)
    assert_equal("Z", elf_groups[1].get_common_item)
  end

  def test__get_elf_group_priority_score
    day_03 = Day03.new("data/day_03_input_test.txt")
    elf_groups = day_03.elf_groups

    assert_equal(18, elf_groups[0].get_elf_group_priority_score)
    assert_equal(52, elf_groups[1].get_elf_group_priority_score)
  end
end
