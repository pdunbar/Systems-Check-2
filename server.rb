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
  standings = {}
  @teams.each do |team|
    standing = {team => {:wins => 0, :losses => 0}}
    @games.each do |game|
      if game[:winner] == team
        standing[team][:wins] += 1
      elsif game[:loser] == team
        standing[team][:losses] += 1
      end
    end
    standings.merge!(standing)
  end
  standings
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
  @teams = create_team_list
  @standings_unsorted = create_leaderboard
  @standings = @standings_unsorted.sort_by { |standing, wins| wins[:wins]}
  @standings = @standings.reverse

  #Unfortunately my sorting is incomplete. My inability to truck through this sorting
  #algorithm has hindered the final completion of this challenge.
  #
  #  @standings_unsorted is the data structure that I want.
  #  {"Patriots"=>{:wins=>4, :losses=>0},
  #    "Broncos"=>{:wins=>2, :losses=>3},
  #    "Colts"=>{:wins=>0, :losses=>4},
  #    "Steelers"=>{:wins=>2, :losses=>1}}

  erb :leaderboard

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
