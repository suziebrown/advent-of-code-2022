class Day01
  attr_reader :items_by_elf
  attr_reader :number_of_elves
  attr_reader :calories_per_elf

  def initialize(input_filename)
    read_input_file(input_filename)
    @calories_per_elf = Array.new(@number_of_elves)
    calculate_calories_per_elf
  end

  def read_input_file(filename)
    lines_by_elf = File.read(filename).split("\n\n")
    @number_of_elves = lines_by_elf.length

    @items_by_elf = lines_by_elf
                      .map { |line| line.split("\n")
                                        .map { |item| Integer(item) } }
  end

  def calculate_calories_per_elf
    @calories_per_elf = @items_by_elf.map { |list| list.sum }
  end

  def get_maximum_calories
    calories_per_elf.max
  end

  def get_top_three_total_calories
    calories_per_elf.sort.reverse[0..2].sum
  end
end


day_01 = Day01.new("data/day_01_input.txt")
puts "Part 1: " + day_01.get_maximum_calories.to_s
puts "Part 2: " + day_01.get_top_three_total_calories.to_s
