class Day02
  attr_reader :input
  attr_reader :total_score
  attr_reader :total_score_2

  def initialize(input_filename)
    read_input_file(input_filename)
    calculate_total_score
    calculate_total_score_2
  end

  def read_input_file(filename)
    lines = File.read(filename).split("\n")
    @input = lines
  end

  def calculate_total_score
    @total_score = (@input.map {|line|
      Round.new(line).get_total_score_for_round
    }).sum
  end

  def calculate_total_score_2
    @total_score_2 = (@input.map {|line|
      Round.new(line).get_total_score_for_round_2
    }).sum
  end
end


class Round
  @@win_combos = [%w[A Y], %w[B Z], %w[C X]]
  @@draw_combos = [%w[A X], %w[B Y], %w[C Z]]
  @@loss_combos = [%w[A Z], %w[B X], %w[C Y]]

  attr_writer :their_move
  attr_writer :my_move
  attr_writer :outcome

  def initialize(line)
    @parts = line.split(" ")
    @their_move = @parts[0]
    @my_move = nil
    @outcome = nil
  end

  def get_total_score_for_round
    @my_move = @parts[1]
    get_shape_score + get_outcome_score
  end

  def get_total_score_for_round_2
    @outcome = @parts[1]
    get_shape_score_2 + get_outcome_score_2
  end

  def get_shape_score
    case @my_move
    when "X"
      1
    when "Y"
      2
    when "Z"
      3
    else
      throw("Unexpected value '#{@my_move}'of my_move")
    end
  end

  def get_shape_score_2
    case @outcome
    when "X"
      @my_move = choose_my_move(@@loss_combos)
    when "Y"
      @my_move = choose_my_move(@@draw_combos)
    when "Z"
      @my_move = choose_my_move(@@win_combos)
    else
      throw("Unexpected value '#{@outcome}'of outcome")
    end

    get_shape_score
  end

  def get_outcome_score
    if @@win_combos.include? [@their_move, @my_move]
      @outcome = "Z"
    elsif @@draw_combos.include? [@their_move, @my_move]
      @outcome = "Y"
    elsif @@loss_combos.include? [@their_move, @my_move]
      @outcome = "X"
    else
      throw("Unexpected combination of moves '#{@their_move}' and '#{@my_move}'")
    end

    get_outcome_score_2
  end

  def get_outcome_score_2
    case @outcome
    when "X"
      0
    when "Y"
      3
    when "Z"
      6
    else
      throw("Unexpected value '#{@outcome}'of outcome")
    end
  end

  def choose_my_move(combos_array)
    (combos_array.find {|combo| combo[0] == @their_move})[1]
  end
end


day_02 = Day02.new("data/day_02_input.txt")
puts "Part 1: " + day_02.total_score.to_s
puts "Part 2: " + day_02.total_score_2.to_s
