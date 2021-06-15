module Fifa
  module Proclubs
    module Apis
      class Club
        attr_accessor :place,
                      :clubId, :clubName,
                      :seasons, :rankingPoints,
                      :bestDivision, :currentDivision,
                      :titlesWon, :leaguesWon,
                      :totalGames, :wins, :ties, :losses,
                      :goals, :goalsAgainst,
                      :averageGoalsPerGame, :averageGoalsAgainstPerGame,
                      :matches

        def initialize(clubId, clubName,
                       seasons, rankingPoints,
                       bestDivision, currentDivision,
                       titlesWon, leaguesWon,
                       totalGames, wins, ties, losses,
                       goals, goalsAgainst,
                       averageGoalsPerGame, averageGoalsAgainstPerGame)

          @clubId = clubId
          @clubName = clubName
          @seasons = seasons
          @rankingPoints = rankingPoints.to_i
          @bestDivision = bestDivision.to_i
          @currentDivision = currentDivision.to_i
          @titlesWon = titlesWon.to_i
          @leaguesWon = leaguesWon.to_i
          @totalGames = totalGames.to_i
          @wins = wins.to_i
          @ties = ties.to_i
          @losses = losses.to_i
          @goals = goals.to_i
          @goalsAgainst = goalsAgainst.to_i
          @averageGoalsPerGame = averageGoalsPerGame.to_i
          @averageGoalsAgainstPerGame = averageGoalsAgainstPerGame.to_i
        end
      end
    end
  end
end