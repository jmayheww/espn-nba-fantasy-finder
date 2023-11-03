# main.rb
require_relative 'api_client'
require_relative 'ui'
require_relative 'player_filter'

require 'dotenv/load'

# Load environment variables
espn_cookie = ENV['espn_s2_cookie']
league_id = ENV['LEAGUE_ID']

begin
  players = APIClient.fetch_players(espn_cookie, league_id)

  display_player_positions

  # Get user's choice for position
  selected_position_name = get_player_position_user_choice

  selected_position_id = POSITION_MAP.key(selected_position_name)

  # Filter players by the selected position
  filtered_players = filter_players_by_position(players, selected_position_id)
  # Debug: Check ratings data for each filtered player

  top_5_players = top_players_by_position(filtered_players, selected_position_id)

  top_5_players.each_with_index do |player, index|
    player_name = player['player']['fullName']
    player_combined_score = player['combinedScore']

    puts '------------------------'
    puts "Top #{selected_position_name} ##{index + 1}"
    puts "#{player_name} | Fantasy Score: #{player_combined_score}"
  end

  # Now you can use players data to display in UI or further processing
rescue JSON::ParserError => e
  puts "JSON Parsing Error: #{e}"
rescue StandardError => e
  puts "HTTP Request Failed: #{e}"
end
