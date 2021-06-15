module Fifa
  module Proclubs
    module Apis
      module Helper
        REFERER = {
          headers: {
            'Referer' => Constants::REFERER_API,
            'Content-Type' => 'application/json',
            'accept' => 'application/json'
          }
        }.freeze

        def self.clubs_rank_top100(platform)
          call_api(Constants::API_URI + Constants::SEASON_RANK_LEADERBOARD % [platform])
        end

        def self.club_search(platform, club_name)
          call_api(Constants::API_URI + Constants::CLUBS::SEARCH % [platform, club_name]).values
        end

        def self.club_stats(platform, club_id)
          call_api(Constants::API_URI + Constants::CLUBS::SEASONAL_STATS % [platform, club_id]).first
        end

        def self.club_member_career_stats(platform, club_id)
          call_api(Constants::API_URI + Constants::MEMBERS::CARREER_STATS % [platform, club_id])
        end

        def self.club_member_stats(platform, club_id)
          call_api(Constants::API_URI + Constants::MEMBERS::CLUB_STATS % [platform, club_id])
        end

        def self.club_info(platform, club_id)
          call_api(Constants::API_URI + Constants::CLUBS::INFO % [platform, club_id])
        end

        def self.settings
          call_api(Constants::API_URI + Constants::SETTINGS)
        end

        def self.platforms
          Constants::PLATFORMS.constants(false).map &Constants::PLATFORMS.method(:const_get)
        end

        private

        def self.call_api(url)
          uri = URI(URI.encode(url))
          result = Fifa::Utils::HTTP.get(uri, options = { parameters: CGI.parse(uri.query) }.merge(REFERER))

          error_msg = "Api call error ! \ncode :#{result.code} \nbody : #{result.body}"
          Fifa::Utils::Log.warning(error_msg) unless result.code == 200
          Fifa::Utils::Log.warning(error_msg) if result.body == {}

          result.body
        end
      end
    end
  end
end
