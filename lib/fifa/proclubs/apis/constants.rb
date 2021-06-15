module Fifa
  module Proclubs
    module Apis
      module Constants
        BASE_URI = 'https://proclubs.ea.com'
        API_URI = "#{BASE_URI}/api/fifa".freeze                                    # Base URI
        REFERER_API = BASE_URI + '/api-docs/index.html?url=/swagger.json'.freeze    # Referer headers

        SETTINGS = '/settings'.freeze                                               # Get divisions informations
        SEASON_RANK_LEADERBOARD = "/seasonRankLeaderboard?platform=%s"              # Get season rank related to a platform

        module MEMBERS
          MEMBERS_URI = 'members'.freeze
          CARREER_STATS = "/#{MEMBERS_URI}/career/stats?platform=%s&clubId=%s"      # Get members of a club / Carrer (Global) Stats
          CLUB_STATS = "/#{MEMBERS_URI}/stats?platform=%s&clubId=%s"                # Get members of a club / CLUB Stats
        end

        module CLUBS
          CLUBS_URI = 'clubs'.freeze
          SEARCH = "/#{CLUBS_URI}/search?platform=%s&clubName=%s"                   # Search a club by NAME and get stats
          INFO = "/#{CLUBS_URI}/info?platform=%s&clubIds=%s"                        # Get information about a club.rb by ID
          SEASONAL_STATS = "/#{CLUBS_URI}/seasonalStats?platform=%s&clubIds=%s"     # Get season stats of club by ID
        end

        module LEADERBOARDS
          PS4_XBOX_ONE_PC = 'ps4-xb1-pc'.freeze
          PS5_XBOX_SXS = 'ps5-xbsxs'.freeze
        end

        module PLATFORMS
          PLAYSTATION_5 = 'ps5'.freeze
          PLAYSTATION_4 = 'ps4'.freeze
          XBOX_SXS = 'xbox-series-xs'.freeze
          XBOX_ONE = 'xboxone'.freeze
          PC = 'pc'.freeze
        end
      end
    end
  end
end