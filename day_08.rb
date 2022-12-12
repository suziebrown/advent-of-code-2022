class Day08
  attr_reader :trees
  attr_reader :number_of_rows
  attr_reader :number_of_columns

  def initialize(input_filename)
    lines = File.read(input_filename).split("\n")
    @trees = lines.map { |line| line.split(//)
      .map { |tree| Integer(tree) }
    }
    @number_of_rows = @trees.length
    @number_of_columns = @trees[0].length
  end

  def get_number_of_visible_trees
    get_number_of_trees_on_perimeter + test__get_number_of_visible_interior_trees
  end

  def get_number_of_trees_on_perimeter
    2 * (@number_of_rows + @number_of_columns) - 4
  end

  def test__get_number_of_visible_interior_trees
    (1..@number_of_columns - 2).sum do |row|
      (1..@number_of_rows - 2).count do |column|
        tree_visible?(row, column)
      end
    end
  end

  def tree_visible?(row, column)
    row == 0 \
    || row == @number_of_columns - 1 \
    || column == 0 \
    || column == @number_of_columns - 1 \
    || tree_visible_from_left?(row, column) \
    || tree_visible_from_right?(row, column) \
    || tree_visible_from_top?(row, column) \
    || tree_visible_from_bottom?(row, column)
  end

  def tree_visible_from_left?(row, column)
    height = @trees[row][column]
    trees_to_left = @trees[row][..column - 1]

    !trees_to_left.any? { |other_tree| other_tree >= height }
  end

  def tree_visible_from_right?(row, column)
    height = @trees[row][column]
    trees_to_right = @trees[row][column + 1..]

    !trees_to_right.any? { |other_tree| other_tree >= height }
  end

  def tree_visible_from_top?(row, column)
    height = @trees[row][column]
    trees_to_top = @trees[..row - 1].map {|row_of_trees| row_of_trees[column] }

    !trees_to_top.any? { |other_tree| other_tree >= height }
  end

  def tree_visible_from_bottom?(row, column)
    height = @trees[row][column]
    trees_to_bottom = @trees[row + 1..].map {|row_of_trees| row_of_trees[column] }

    !trees_to_bottom.any? { |other_tree| other_tree >= height }
  end
end


day_08 = Day08.new("data/day_08_input.txt")
puts "Part 1: " + day_08.get_number_of_visible_trees.to_s
# puts "Part 2: " + day_08.
