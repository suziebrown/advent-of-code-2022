class Day03
  @@letters_in_alphabet = 26
  @@ascii_uppercase_a = 65
  @@ascii_lowercase_a = 97

  attr_reader :rucksacks
  attr_reader :elf_groups

  def initialize(input_filename)
    read_input_file(input_filename)
    get_elf_groups
  end

  def read_input_file(filename)
    @rucksacks = File.read(filename).split("\n")
  end

  def get_total_priority_of_rucksacks
    @rucksacks.sum do |rucksack|
      Rucksack.new(rucksack).get_rucksack_priority_score
    end
  end

  def get_total_priority_of_elf_groups
    @elf_groups.sum do |group|
      group.get_elf_group_priority_score
    end
  end

  def get_elf_groups
    number_of_rucksacks = @rucksacks.length

    if number_of_rucksacks % 3 != 0
      throw("Expected a multiple of three rucksacks, got #{number_of_rucksacks}")
    end

    @elf_groups = Array.new(number_of_rucksacks / 3)

    group_index = 0
    while group_index < number_of_rucksacks / 3 do
      @elf_groups[group_index] = ElfGroup.new(@rucksacks[3 * group_index.. 3 * group_index + 2])
      group_index += 1
    end
  end

  def self.get_item_priority(item)
    unless item.length == 1
      throw("Unexpected item code #{item}")
    end

    ascii_code = item.ord

    case ascii_code
    when @@ascii_uppercase_a..@@ascii_uppercase_a + @@letters_in_alphabet
      ascii_code - @@ascii_uppercase_a + @@letters_in_alphabet + 1
    when @@ascii_lowercase_a..@@ascii_lowercase_a + @@letters_in_alphabet
      ascii_code - @@ascii_lowercase_a + 1
    else
      throw("Unexpected item code #{item}")
    end
  end
end


class Rucksack
  attr_reader :compartment_1
  attr_reader :compartment_2

  def initialize(items)
    @items = items
    get_compartments
  end

  def get_compartments
    number_of_items = @items.length

    if number_of_items % 2 != 0
      throw("Expected an even number of items in rucksack - got #{number_of_items}")
    end

    @compartment_1 = @items[0..number_of_items / 2 - 1].split(//)
    @compartment_2 = @items[number_of_items / 2..number_of_items - 1].split(//)
  end

  def get_rucksack_priority_score
    Day03.get_item_priority(get_duplicated_item)
  end

  def get_duplicated_item
    duplicates = @compartment_1 & @compartment_2

    if duplicates.length != 1
      throw("Unexpected number of duplicates (#{duplicates.length})")
    end

    duplicates[0]
  end
end


class ElfGroup
  attr_reader :elf_1
  attr_reader :elf_2
  attr_reader :elf_3

  def initialize(rucksacks)
    @elf_1 = rucksacks[0].split(//)
    @elf_2 = rucksacks[1].split(//)
    @elf_3 = rucksacks[2].split(//)
  end

  def get_elf_group_priority_score
    Day03.get_item_priority(get_common_item)
  end

  def get_common_item
    common_items = @elf_1 & @elf_2 & @elf_3

    unless common_items.length == 1
      throw("Expected exactly one item in common, got #{common_items.length}")
    end

    common_items[0]
  end
end


day_03 = Day03.new("data/day_03_input.txt")
puts "Part 1: " + day_03.get_total_priority_of_rucksacks.to_s
puts "Part 2: " + day_03.get_total_priority_of_elf_groups.to_s
