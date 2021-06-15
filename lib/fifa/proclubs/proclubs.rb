require 'fifa/proclubs/beans/club'
require 'fifa/proclubs/beans/matches'
require 'fifa/proclubs/beans/member'
require 'fifa/proclubs/beans/member_career_stats'
require 'fifa/proclubs/beans/member_club_stats'
require 'fifa/proclubs/beans/position_count'
require 'fifa/proclubs/beans/result'

require 'fifa/proclubs/apis/constants'
require 'fifa/proclubs/apis/utils'
require 'fifa/proclubs/apis/error_handler'
require 'fifa/proclubs/apis/helper'
require 'fifa/proclubs/apis/manager'

module Fifa
  module Proclubs
    module Apis
      def self.clubs_rank_top100(platform)
        check_parameters(options: { platform: platform })
        Apis::Manager.clubs_rank_top100(platform)
      end

      def self.club_rank_top100(platform, club_name)
        check_parameters(options: { platform: platform, club_name: club_name })
        Apis::Manager.club_rank_top100(platform, club_name)
      end

      def self.club_stats(platform, club_name)
        check_parameters(options: { platform: platform, club_name: club_name })
        Apis::Manager.club_stats(platform, club_name)
      end

      def self.club_matches_history(platform, club_name)
        check_parameters(options: { platform: platform, club_name: club_name })
        Apis::Manager.club_matches_history(platform, club_name)
      end

      def self.player_datas(platform, club_name, player_name)
        check_parameters(options: { platform: platform, club_name: club_name, player_name: player_name })
        Apis::Manager.player_datas(platform, club_name, player_name)
      end

      def self.player_datas_top100(platform, player_name)
        check_parameters(options: { platform: platform, player_name: player_name })
        Apis::Manager.player_datas_top100(platform, player_name)
      end

      private

      def self.check_parameters(options: {})
        Apis::Utils.check_platform('platform', options[:platform]) if options.key?(:platform)
        Fifa::Utils::Check.string('club_name', options[:club_name]) if options.key?(:club_name)
        Fifa::Utils::Check.string('player_name', options[:player_name]) if options.key?(:player_name)
      end
    end
  end
end

