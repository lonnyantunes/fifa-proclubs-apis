module Fifa
  module Proclubs
    module Apis
      class MemberCareerStats
        attr_accessor :name,
                      :ratingAve, :favoritePosition,
                      :gamesPlayed, :manOfTheMatch, :goals, :assists

        def initialize(name, ratingAve, favoritePosition, gamesPlayed, manOfTheMatch, goals, assists)
          @name = name
          @ratingAve = ratingAve
          @favoritePosition = favoritePosition
          @gamesPlayed = gamesPlayed
          @manOfTheMatch = manOfTheMatch
          @goals = goals
          @assists = assists
        end
      end
    end
  end
end
