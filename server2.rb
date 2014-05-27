require 'sinatra'
require 'csv'
require 'shotgun'
require 'pry'

def load_games
  games =[]
  CSV.foreach('games.csv', headers: true) do |row|
    game = {
      home_team: row ["home_team"],
      away_team: row["away_team"],
      home_score: row["home_score"].to_i,
      away_score: row["away_score"].to_i,
      winner: "",
      loser: ""
    }

    if game[:home_score] > game[:away_score]
      game[:winner] = game[:home_team]
      game[:loser] = game[:away_team]
    elsif game[:home_score] < game[:away_score]
      game[:winner] = game[:away_team]
      game[:loser] = game[:home_team]
    elsif
      game[:winner] = "tie"
      game[:loser] = "tie"
    end
  games << game
  end
  games
end

def create_team_list
  teams = []
  @games.each do |game|
    if !teams.include? game[:home_team]
      teams << game[:home_team]
    end
    if !teams.include? game[:away_team]
      teams << game[:away_team]
    end

  end
  @teams = teams
end

def create_leaderboard
  leaderboard = []
  teams.each do |team|


  end



end

#Index of Teams
get '/' do
  @games = load_games
  @teams = create_team_list

  erb :index
end

#Show top teams sorted by two criteria 'wins vs losses'
get '/leaderboard' do
  @games = load_games
  @leaderboard = create_leaderboard

erb :leaderboard
binding.pry
end


get '/teams' do

  redirect to('/')

end

#show winning/loss history of each team
get '/teams/:team' do
  @games = load_games
  @teams = create_team_list

  erb :teams
end
