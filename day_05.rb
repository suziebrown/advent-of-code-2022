class Day05
  attr_reader :configuration
  attr_reader :moves

  def initialize(input_filename)
    read_input_file(input_filename)
  end

  def read_input_file(filename)
    configuration_and_moves = File.read(filename).split("\n\n")
    @configuration = Stacks.new(configuration_and_moves[0])
    @moves = configuration_and_moves[1].split("\n")
  end
end


class Stacks
  def initialize(input)
    lines = input.split("\n")
    @number_of_stacks = 1 # qq
  end
end