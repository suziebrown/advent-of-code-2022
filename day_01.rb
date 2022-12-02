class Day01
  attr_reader :input
  attr_reader :number_of_elves
  attr_reader :calories_per_elf

  def initialize(input_filename)
    read_input_file(input_filename)
    @calories_per_elf = Array.new(@number_of_elves)
    calculate_calories_per_elf
  end

  def read_input_file(filename)
    lines = File.read(filename).split("\n")
    @input = lines.map {|line| line == "" ? nil : Integer(line)}
    @number_of_elves = (@input.select {|line| line.nil? }).length + 1
  end

  def calculate_calories_per_elf
    elf_index = 0
    calories_per_elf[0] = 0

    @input.each { |calories|
      if calories.nil?
        elf_index += 1
        @calories_per_elf[elf_index] = 0
      else
        @calories_per_elf[elf_index] += calories
      end
    }
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
