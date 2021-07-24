require 'fifa/utils/utils'
require 'fifa/proclubs/proclubs'

module Fifa
  module Game
    def self.clubs_rank_top100(is_debug, is_verbose, platform)
      init(is_debug, is_verbose, __method__.to_s)
      Proclubs::Apis.clubs_rank_top100(platform)
    end

    def self.club_rank_top100(is_debug, is_verbose, platform, club_name)
      init(is_debug, is_verbose, __method__.to_s)
      Proclubs::Apis.club_rank_top100(platform, club_name)
    end

    def self.club_stats(is_debug, is_verbose, platform, club_name)
      init(is_debug, is_verbose, __method__.to_s)
      Proclubs::Apis.club_stats(platform, club_name)
    end

    def self.club_matches_history(is_debug, is_verbose, platform, club_name)
      init(is_debug, is_verbose, __method__.to_s)
      Proclubs::Apis.club_matches_history(platform, club_name)
    end

    def self.club_members(is_debug, is_verbose, platform, club_name)
      init(is_debug, is_verbose, __method__.to_s)
      Proclubs::Apis.club_members(platform, club_name)
    end

    def self.player_datas(is_debug, is_verbose, platform, club_name, player_name)
      init(is_debug, is_verbose, __method__.to_s)
      Proclubs::Apis.player_datas(platform, club_name, player_name)
    end

    def self.player_datas_top100(is_debug, is_verbose, platform, player_name)
      init(is_debug, is_verbose, __method__.to_s)
      Proclubs::Apis.player_datas_top100(platform, player_name)
    end

    private

    def self.init(is_debug, is_verbose, method)
      Utils::Environment::Setup.init('fifa-proclubs-apis', is_debug, is_verbose, method)
    end
  end
end
