module Fifa
  module Proclubs
    module Apis
      class MemberClubStats
        attr_accessor :name, :clubName,
                      :proName, :proOverall, :favoritePosition,
                      :gamesPlayed, :manOfTheMatch, :goals, :assists,
                      :winRate, :shotSuccessRate, :passesMade, :passSuccessRate,
                      :tacklesMade, :tackleSuccessRate, :redCards,
                      :cleanSheetsDef, :cleanSheetsGK

        def initialize(name, proName, proOverall, favoritePosition,
                       gamesPlayed, manOfTheMatch, goals, assists,
                       winRate, shotSuccessRate, passesMade, passSuccessRate,
                       tacklesMade, tackleSuccessRate, redCards,
                       cleanSheetsDef, cleanSheetsGK)

          @name = name
          @proName = proName
          @proOverall = proOverall
          @favoritePosition = favoritePosition
          @gamesPlayed = gamesPlayed
          @manOfTheMatch = manOfTheMatch
          @goals = goals
          @assists = assists
          @winRate = winRate
          @shotSuccessRate = shotSuccessRate
          @passesMade = passesMade
          @passSuccessRate = passSuccessRate
          @tacklesMade = tacklesMade
          @tackleSuccessRate = tackleSuccessRate
          @redCards = redCards
          @cleanSheetsDef = cleanSheetsDef
          @cleanSheetsGK = cleanSheetsGK
        end
      end
    end
  end
end
