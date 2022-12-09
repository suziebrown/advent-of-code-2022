class Day04
  attr_reader :pairs

  def initialize(input_filename)
    read_input_file(input_filename)
  end

  def read_input_file(filename)
    lines = File.read(filename).split("\n")
    @pairs = lines.map { |line| Pair.new(line) }
  end

  def get_number_of_pairs_with_fully_containing
    @pairs.count { |pair| pair.one_of_pair_fully_contained? }
  end

  def get_number_of_pairs_with_any_overlap
    @pairs.count { |pair| pair.has_any_overlap? }
  end
end


class Pair
  attr_reader :site_1
  attr_reader :site_2

  def initialize(line)
    sites = line.split(",")
    @site_1 = get_sites_from_range(sites[0])
    @site_2 = get_sites_from_range(sites[1])
  end

  def get_sites_from_range(range)
    ends = range.split("-")
    start = Integer(ends[0])
    finish = Integer(ends[1])

    (start..finish).to_a
  end

  def one_of_pair_fully_contained?
    (@site_1 - @site_2).empty? || (@site_2 - @site_1).empty?
  end

  def has_any_overlap?
    !(@site_1 & @site_2).empty?
  end
end


day_04 = Day04.new("data/day_04_input.txt")
puts "Part 1: " + day_04.get_number_of_pairs_with_fully_containing.to_s
puts "Part 2: " + day_04.get_number_of_pairs_with_any_overlap.to_s
