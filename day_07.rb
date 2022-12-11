class Day07
  @@root_directory_id = 1
  @@small_directory_threshold = 100000
  @@total_available_storage = 70000000
  @@storage_needed_for_update = 30000000

  attr_reader :lines
  attr_reader :directory_items
  attr_reader :working_directory_id

  attr_writer :directory_items
  attr_writer :working_directory_id

  def initialize(input_filename)
    @lines = File.read(input_filename).split("\n")
    @directory_items = { 1 => Directory.new("/", @@root_directory_id) }
    @working_directory_id = 1
    parse_input_lines
  end

  def get_total_size_of_small_directories
    find_small_directories.sum { |id, dir| dir.get_size }
  end

  def find_small_directories
    @directory_items.find_all do |id, item|
      id != @@root_directory_id \
        && item.class == Directory \
        && item.get_size <= @@small_directory_threshold
    end
  end

  def get_size_of_directory_to_delete
    sufficiently_large_directories = find_sufficiently_large_directories(get_additional_storage_required)
    sufficiently_large_directories.map{ |id, dir| dir.get_size }.min
  end

  def get_additional_storage_required
    storage_used = directory_items[@@root_directory_id].get_size
    storage_available = @@total_available_storage - storage_used

    @@storage_needed_for_update - storage_available
  end

  def find_sufficiently_large_directories(storage_required)
    @directory_items.find_all do |id, item|
      item.class == Directory \
        && item.get_size >= storage_required
    end
  end

  def parse_input_lines
    @lines.map do |line|
      parse_input_line(line)
    end
  end

  def parse_input_line(line)
    if line[0] == "$"
      parse_command(line)
    else
      parse_output(line)
    end
  end

  def parse_command(line)
    if line == "$ cd .."
      @working_directory_id = @directory_items[@working_directory_id].parent_id
    elsif line == "$ cd /"
      @working_directory_id = @@root_directory_id
    elsif line[0..3] == "$ cd"
      child_directory_name = line[5..]
      go_to_child_directory(child_directory_name)
    end
  end

  def parse_output(line)
    working_directory = @directory_items[@working_directory_id]

    if line[0..2] == "dir"
      make_directory(working_directory, line[4..])
    else
      size, name = line.split(" ")
      new_file = PlainFile.new(name, @directory_items.length + 1, Integer(size))
      working_directory.add_child(new_file)
      @directory_items[new_file.id] = new_file
    end
  end

  def go_to_child_directory(directory_name)
    working_directory = @directory_items[@working_directory_id]

    unless working_directory.children.any? { |child| child.name == directory_name }
      make_directory(working_directory, directory_name)
    end

    @working_directory_id = working_directory.children.find { |child| child.name == directory_name }.id
  end

  def make_directory(working_directory, new_directory_name)
    new_directory = Directory.new(new_directory_name, @directory_items.length + 1)
    new_directory.set_parent_id @working_directory_id
    working_directory.add_child new_directory
    @directory_items[new_directory.id] = new_directory
  end
end


class DirectoryItem
  attr_reader :id
  attr_reader :name
  attr_reader :parent_id

  def initialize(name, id)
    @id = id
    @name = name
  end

  def set_parent_id(parent_id)
    @parent_id = parent_id
  end

  def get_size
    0
  end
end


class Directory < DirectoryItem
  attr_reader :children

  def initialize(name, id)
    super(name, id)
    @children = []
  end

  def add_child(directory_item)
    unless @children.map { |child| child.id }.include? directory_item.id
      directory_item.set_parent_id(@id)
      @children.push(directory_item)
    end
  end

  def get_size
    @children.sum do |child|
      child.get_size
    end
  end
end


class PlainFile < DirectoryItem
  def initialize(name, id, size)
    super(name, id)
    @size = size
  end

  def get_size
    @size
  end
end


day_07 = Day07.new("data/day_07_input.txt")
puts "Part 1: " + day_07.get_total_size_of_small_directories.to_s
puts "Part 2: " + day_07.get_size_of_directory_to_delete.to_s
