class Day05
  attr_reader :stacks
  attr_reader :moves

  def initialize(input_filename)
    read_input_file(input_filename)
  end

  def read_input_file(filename)
    configuration_and_moves = File.read(filename).split("\n\n")
    @stacks = Stacks.new(configuration_and_moves[0])
    @moves = configuration_and_moves[1].split("\n")
  end

  def apply_moves_and_get_top_crates
    apply_moves
    get_top_crates
  end

  def apply_moves_2_and_get_top_crates
    apply_moves_2
    get_top_crates
  end

  def apply_moves
    @moves.map do |move|
      @stacks.apply_move(move)
    end
  end

  def apply_moves_2
    @moves.map do |move|
      @stacks.apply_move_2(move)
    end
  end

  def get_top_crates
    top_crates = @stacks.crates.map {|stack| stack[-1]}
    top_crates.join("")
  end
end


class Stacks
  attr_reader :number_of_stacks
  attr_reader :crates

  def initialize(input)
    lines = input.split("\n")
    # only works for single-digit stack numbers
    stack_numbers = lines.pop.gsub!(" ", "")

    @number_of_stacks = Integer(stack_numbers[-1])
    @crates = Array.new(@number_of_stacks)
    get_initial_crate_configuration(lines.reverse!)
  end

  def get_initial_crate_configuration(crates_input)
    for stack_number in 0..@number_of_stacks - 1 do
      @crates[stack_number] = Stacks.get_crates_in_stack(stack_number, crates_input)
    end
  end

  def apply_move(move)
    number_of_crates_to_move, from_stack, to_stack = Stacks.parse_move_instruction(move)

    number_of_crates_moved = 0
    while number_of_crates_moved < number_of_crates_to_move do
      @crates[to_stack].push(@crates[from_stack].pop)
      number_of_crates_moved += 1
    end
  end

  def apply_move_2(move)
    number_of_crates_to_move, from_stack, to_stack = Stacks.parse_move_instruction(move)

    @crates[to_stack].concat(@crates[from_stack].pop(number_of_crates_to_move))
  end

  def self.parse_move_instruction(move)
    instruction_parts = move.split(" ")
    number_of_crates_to_move = Integer(instruction_parts[1])
    from_stack = Integer(instruction_parts[3]) - 1
    to_stack = Integer(instruction_parts[5]) - 1

    return number_of_crates_to_move, from_stack, to_stack
  end

  def self.get_crates_in_stack(stack_number, crates_input)
    crates = Array.new()
    column_number = Stacks.get_input_column_number(stack_number)

    crates_input.map do |line|
      if line[column_number] != nil and line[column_number] != " "
        crates.push(line[column_number])
      end
    end

    crates
  end

  def self.get_input_column_number(stack_number)
    4 * stack_number + 1
  end
end


puts "Part 1: " + Day05.new("data/day_05_input.txt").apply_moves_and_get_top_crates
puts "Part 2: " + Day05.new("data/day_05_input.txt").apply_moves_2_and_get_top_crates
