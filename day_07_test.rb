require 'minitest/autorun'
require_relative 'day_07'

class Day07Test < Minitest::Test
  def test__reads_input_file
    day_07 = Day07.new("data/day_07_input_test.txt")
    assert_equal(23, day_07.lines.count)
    assert_equal("$ cd /", day_07.lines[0])
  end

  def test__parse_input_lines
    day_07 = Day07.new("data/day_07_input_test.txt")
    assert_equal(14, day_07.directory_items.length)
    assert_equal(4, day_07.directory_items[1].children.length)
    assert_equal(4, day_07.directory_items[2].children.length)
  end

  def test__get_total_size_of_small_directories
    day_07 = Day07.new("data/day_07_input_test.txt")
    assert_equal(95437, day_07.get_total_size_of_small_directories)
  end

  def test__get_size_of_directory_to_delete
    day_07 = Day07.new("data/day_07_input_test.txt")
    assert_equal(24933642, day_07.get_size_of_directory_to_delete)
  end

  def test__get_additional_storage_required
    day_07 = Day07.new("data/day_07_input_test.txt")
    assert_equal(8381165, day_07.get_additional_storage_required)
  end

  def test__find_sufficiently_large_directories
    day_07 = Day07.new("data/day_07_input_test.txt")
    assert_equal([1, 5], day_07.find_sufficiently_large_directories(8381165).map{ |id, dir| id})
  end

  def test__find_small_directories
    day_07 = Day07.new("data/day_07_input_test.txt")
    ids = day_07.find_small_directories.map {|id, dir| id}
    assert_equal([2, 6], ids)
  end

  def test__parse_command
    day_07 = Day07.new("data/day_07_input_test.txt")
    day_07.directory_items = { 1 => Directory.new("/", 1) }
    day_07.working_directory_id = 1

    day_07.parse_command("$ cd /")
    assert_equal(1, day_07.directory_items.length)
    assert_equal("/", day_07.directory_items[1].name)
    assert_equal(1, day_07.working_directory_id)

    day_07.parse_command("$ cd a")
    assert_equal(2, day_07.directory_items.length)
    assert_equal("a", day_07.directory_items[2].name)
    assert_equal(2, day_07.working_directory_id)

    day_07.parse_command("$ cd ..")
    assert_equal(2, day_07.directory_items.length)
    assert_equal(1, day_07.working_directory_id)
  end

  def test__parse_output
    day_07 = Day07.new("data/day_07_input_test.txt")
    day_07.directory_items = { 1 => Directory.new("/", 1) }
    day_07.working_directory_id = 1

    day_07.parse_command("$ cd /")
    day_07.parse_output("125 b")
    assert_equal(2, day_07.directory_items.length)
    assert_equal("b", day_07.directory_items[2].name)
    assert_equal(125, day_07.directory_items[2].get_size)

    day_07.parse_output("dir c")
    assert_equal(3, day_07.directory_items.length)
    assert_equal("c", day_07.directory_items[3].name)
  end

  def test__directory__add_child
    dir = Directory.new("item 1", 1)
    assert_equal([], dir.children)

    dir.add_child(PlainFile.new("item 2", 2, 100))
    assert_equal(1, dir.children.length)

    dir.add_child(Directory.new("item 3", 3))
    assert_equal(2, dir.children.length)

    dir.add_child(Directory.new("item 2 again?", 2))
    assert_equal(2, dir.children.length)
  end

  def test__directory__get_size
    dir_1 = Directory.new("item 1", 1)
    dir_2 = Directory.new("item 2", 2)

    dir_1.add_child(PlainFile.new("item 3", 3, 100))
    assert_equal(100, dir_1.get_size)

    dir_1.add_child(dir_2)
    assert_equal(100, dir_1.get_size)

    dir_2.add_child(PlainFile.new("item 4", 4, 250))
    assert_equal(350, dir_1.get_size)
  end

  def test__plain_file__get_size
    file = PlainFile.new("name", 2, 100)
    assert_equal(100, file.get_size)
  end
end
