class Day06
  @@end_of_packet_marker_length = 4
  @@start_of_packet_marker_length = 14

  attr_reader :input

  def initialize(input_filename)
    @input = File.read(input_filename)
    @last_four_characters = @input[0..@@end_of_packet_marker_length - 1].split(//)
    @last_fourteen_characters = @input[0..@@start_of_packet_marker_length - 1].split(//)
  end

  def get_first_packet_end
    if packet_end?
      return @@end_of_packet_marker_length - 1
    end

    position = @@end_of_packet_marker_length
    until packet_end? do
      if position >= @input.length
        throw("Searched entire string but didn't find end of packet")
      end

      @last_four_characters = @last_four_characters[1..3].push(@input[position])
      position += 1
    end

    position
  end

  def get_first_packet_start
    if packet_start?
      return @@start_of_packet_marker_length - 1
    end

    position = @@start_of_packet_marker_length
    until packet_start? do
      if position >= @input.length
        throw("Searched entire string but didn't find start of packet")
      end

      @last_fourteen_characters = @last_fourteen_characters[1..13].push(@input[position])
      position += 1
    end

    position
  end

  def packet_end?
    Day06.all_distinct?(@last_four_characters)
  end

  def packet_start?
    Day06.all_distinct?(@last_fourteen_characters)
  end

  def self.all_distinct?(array)
    array.tally.all? { |char, count| count < 2 }
  end
end


day_06 = Day06.new("data/day_06_input.txt")
puts "Part 1: " + day_06.get_first_packet_end.to_s
puts "Part 2: " + day_06.get_first_packet_start.to_s
