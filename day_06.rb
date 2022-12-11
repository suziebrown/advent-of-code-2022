class Day06
  attr_reader :input
  attr_reader :last_four_characters_tally
  attr_writer :last_four_characters_tally

  def initialize(input_filename)
    @input = File.read(input_filename)
    @last_four_characters_tally = @input[0..3].split(//).tally
  end

  def get_first_packet_end
    if Day06.packet_end?(@last_four_characters_tally)
      return 3
    end

    position = 4
    until Day06.packet_end?(@last_four_characters_tally) do
      if position >= @input.length
        throw("Searched entire string but didn't find end of packet")
      end

      character_to_add = @input[position]
      character_to_remove = @input[position - 3]

      update_tally(character_to_add, character_to_remove)
      position += 1
    end

    position
  end

  def update_tally(character_to_add, character_to_remove)
    if character_to_add == character_to_remove
      return
    end

    @last_four_characters_tally.update { |char,count| [char == character_to_remove] ? count - 1 : count }

    if @last_four_characters_tally.has_key? character_to_add
      @last_four_characters_tally.update { |char,count| [char == character_to_add] ? count + 1 : count }
    else
      @last_four_characters_tally.update({ character_to_add => 1 })
    end
  end

  def self.packet_end?(last_four_characters_tally)
    last_four_characters_tally.all? { |character, count| count < 2 }
  end
end


day_06 = Day06.new("data/day_06_input.txt")
puts "Part 1: " + day_06.get_first_packet_end.to_s
# puts "Part 2: " + day_06.to_s
