# api_client.rb
require 'net/http'
require 'json'
require 'uri'

module APIClient
  def self.fetch_players(espn_cookie, league_id)
    uri = URI("https://fantasy.espn.com/apis/v3/games/fba/seasons/2024/segments/0/leagues/#{league_id}?scoringPeriodId=17&view=kona_player_info")
    headers = {
      'Origin' => 'https://fantasy.espn.com',
      'Cookie' => espn_cookie,
      'Accept' => 'application/json',
      'Authority' => 'lm-api-reads.fantasy.espn.com',
      'Connection' => 'keep-alive',
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36'
      # 'X-Fantasy-Filter' => filter # Remove this if you don't have a filter or don't know what filter to apply.
    }

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri, headers)
      http.request(request)
    end

    JSON.parse(response.body)['players']
  end

  def self.fetch_teams(espn_cookie, league_id)
    uri = URI("https://fantasy.espn.com/apis/v3/games/fba/seasons/2024/segments/0/leagues/#{league_id}?view=mTeam")
    headers = {
      'Origin' => 'https://fantasy.espn.com',
      'Cookie' => espn_cookie,
      'Accept' => 'application/json',
      'Authority' => 'lm-api-reads.fantasy.espn.com',
      'Connection' => 'keep-alive',
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36'
    }

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri, headers)
      http.request(request)
    end

    JSON.parse(response.body)['teams']
  end
end
