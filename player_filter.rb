def filter_players_by_position(players, position_id)
  players.select { |player| player['player']['defaultPositionId'] == position_id }
end

# def position_top_5_players_by_total_ranking(players)
#   # Debug: Check input data
#   puts "Filtered players count: #{players.count}"

#   # Filter out players with no total ranking data
#   players_with_ranking = players.select do |player|
#     player.dig('player', 'ratings', '0', 'totalRanking').to_i > 0
#   end

#   # Debug: Check players after filtering
#   puts "Players with ranking count: #{players_with_ranking.count}"

#   # Sort players by total ranking
#   sorted_players = players_with_ranking.sort_by do |player|
#     player.dig('player', 'ratings', '0', 'totalRanking')
#   end

#   # Debug: Check sorted players
#   sorted_players.first(5).each do |p|
#     puts "Sorted player: #{p.dig('player',
#                                  'fullName')} - Total Ranking: #{p.dig('player', 'ratings', '0', 'totalRanking')}"
#   end

#   # Get the top 5 players based on total ranking
#   top_5_players = sorted_players.first(5)

#   top_5_players.map do |player|
#     {
#       name: player.dig('player', 'fullName'),
#       total_ranking: player.dig('player', 'ratings', '0', 'totalRanking')
#     }
#   end
# rescue StandardError => e
#   puts "An error occurred: #{e}"
#   []
# end

def calculate_combined_score(stats)
  # Define your own weights based on your league's scoring system
  average_weight = 0.5
  total_weight = 0.5

  average_score = stats['appliedAverage'].to_f
  total_score = stats['appliedTotal'].to_f

  # Calculate combined score
  combined_score = (average_score * average_weight) + (total_score * total_weight)
  combined_score.round
end

def top_players_by_position(players, position, number_of_players = 5)
  # Filter players by position
  players_at_position = players.select { |p| p['player']['defaultPositionId'] == position }

  # Calculate combined score for each player
  players_at_position.each do |player|
    # Debug: Print the player stats data
    # puts player

    # Ensure there are stats available before calculating the combined score
    player['combinedScore'] = if player['player']['stats'].empty?
                                0
                              else
                                calculate_combined_score(player['player']['stats'].first)
                              end

    # Debug output
    # puts "Player: #{player['player']['fullName']}, Combined Score: #{player['combinedScore']}"
  end

  # Sort by the combined score in descending order (higher is better)
  sorted_players = players_at_position.sort_by { |p| -p['combinedScore'] }

  # Take the top number_of_players
  sorted_players.first(number_of_players)
end
