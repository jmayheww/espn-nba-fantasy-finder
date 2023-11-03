# ui.rb
POSITION_MAP = {
  1 => 'Point Guard (PG)',
  2 => 'Shooting Guard (SG)',
  3 => 'Small Forward (SF)',
  4 => 'Power Forward (PF)',
  5 => 'Center (C)'
}

def display_player_positions
  puts 'Please select a player position:'
  POSITION_MAP.each do |key, value|
    puts "#{key}. #{value}"
  end
end

def get_player_position_user_choice
  selected_position = nil
  until selected_position
    choice = gets.chomp.to_i
    if choice.between?(1, POSITION_MAP.length)
      selected_position = POSITION_MAP[choice]
    else
      puts 'Invalid choice. Please try again.'
      display_player_positions
    end
  end
  selected_position
end
