require 'set'

class Day09
  attr_reader :head_moves
  attr_reader :head_position
  attr_reader :tail_position
  attr_reader :positions_visited_by_tail

  def initialize(input_filename)
    @head_position = Position.new(0, 0)
    @tail_position = Position.new(0, 0)
    @positions_visited_by_tail = Set.new([@tail_position])
    @head_moves = File.read(input_filename).split("\n")
  end

  def get_number_of_positions_visited_by_tail
    apply_all_moves
    @positions_visited_by_tail.length
  end

  def apply_all_moves
    @head_moves.map { |move| apply_move(move) }
  end

  def apply_move(move)
    direction = move[0]
    distance = Integer(move[2..])

    (1..distance).map do
      @head_position.move_one_step(direction)
      move_tail_to_touch_head
    end
  end

  def move_tail_to_touch_head
    if @tail_position.is_touching(@head_position)
      return
    end

    @tail_position.directions_towards(@head_position).map do |direction|
      @tail_position.move_one_step(direction)
    end

    @positions_visited_by_tail << @tail_position.clone
  end
end

class Position
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  # Need to override the hash method in order to use set operations
  def ==(other)
    @x == other.x && @y == other.y
  end
  def hash
    [@x, @y].hash
  end

  def move_one_step(direction)
    case direction
    when 'L'
      @x -= 1
    when 'R'
      @x += 1
    when 'U'
      @y += 1
    when 'D'
      @y -= 1
    else
      throw("Unexpected direction '#{direction}'")
    end
  end

  def is_touching(other_position)
    (@x - other_position.x).abs <= 1 \
    && (@y - other_position.y).abs <= 1
  end

  def directions_towards(other_position)
    x_delta = other_position.x - @x
    y_delta = other_position.y - @y

    case [x_delta, y_delta]
    when [0, 2] then %w[U]
    when [0, -2] then %w[D]
    when [-2, 0] then %w[L]
    when [2, 0] then %w[R]
    when [1, 2] then %w[U R]
    when [2, 1] then %w[U R]
    when [2, -1] then %w[D R]
    when [1, -2] then %w[D R]
    when [-1, 2] then %w[U L]
    when [-2, 1] then %w[U L]
    when [-1, -2] then %w[D L]
    when [-2, -1] then %w[D L]
    else
      throw("Unexpected combination of x_delta (#{x_delta}) and y_delta (#{y_delta})")
    end
  end
end


day_09 = Day09.new("data/day_09_input.txt")
puts "Part 1: " + day_09.get_number_of_positions_visited_by_tail.to_s
