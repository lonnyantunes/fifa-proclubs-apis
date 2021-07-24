module Fifa
  module Proclubs
    module Apis
      module ErrorMessageHandler
        TOP100_NO_CLUBS = "Platform '%s' : there is no clubs in Top 100 ?! (api bug ???)"
        TOP100_CLUB_DOESNT_EXIST = "Platform '%s' : club '%s' doesn't exist in top 100 !"
        CLUB_NOT_FOUND = "Platform '%s' : club '%s' not found !"
        CLUB_ID_NOT_FOUND = "Platform '%s' : club '%s' not found ! (clubID not found from clubName)"
        CLUB_STATS_NOT_FOUND = "Platform '%s' : no club statistics found for club '%s'"
        CLUB_MATCHES_HISTORY_NOT_FOUND = "Platform '%s' : no matches history statistics found for club '%s'"
        PLAYER_NOT_FOUND_IN_CLUB = "player '%s' not found in club '%s'"
        ERROR_CAREER_STATS = "Career statistics : %s"
        ERROR_CLUB_STATS = "Club statistics : %s"
        ERROR_CLUB_MEMBERS_STATS = "Platform '%s' : no members found for club '%s'"
        ERROR_CLUB_MEMBER_STATS = "#{CLUB_STATS_NOT_FOUND} and member %s"
        TOP100_PLAYER_NOT_FOUND = "Player '%s' not found in the top 100"

        def self.error_handler(error_message)
          Fifa::Utils::Log.warning(error_message)
          error_message
        end

      end
    end
  end
end
