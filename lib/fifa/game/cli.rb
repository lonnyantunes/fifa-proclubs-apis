require 'thor'
require 'fifa/utils/utils'
require 'fifa/game/version'
require 'fifa/game'

module Fifa
  module Game
    class CLI < Thor
      class_option :debug, type: :boolean, default: false, aliases: '-d'
      class_option :verbose, type: :boolean, default: false, aliases: '-v'

      desc 'version', 'Display current version'
      map %w[-v --version] => :version
      def version
        say "Version #{Fifa::Game::VERSION}"
      end

      desc 'clubs_rank_top100 [-d|-v|-p]', 'To get datas about all top 100 clubs'
      long_desc <<-LONGDESC
      The method 'clubs_rank_top100' is used to get datas about all top 100 clubs

      > from: Lonny Antunes
      LONGDESC
      method_option :platform, type: :string, default: nil, aliases: '-p'

      def clubs_rank_top100
        Fifa::Game.clubs_rank_top100(
          options[:debug],
          options[:verbose],
          options[:platform]
        )
      rescue => error
        Fifa::Utils::Log.error("Log path : #{Fifa::Utils::Log.log_path}\n")
        raise error
      end

      desc 'club_rank_top100 [-d|-v|-p|-c]', 'To get data on a club in the top 100'
      long_desc <<-LONGDESC
      The method 'club_rank_top100' is used to get ata on a club in the top 100

      > from: Lonny Antunes
      LONGDESC
      method_option :platform,  type: :string, default: nil, aliases: '-p'
      method_option :club_name, type: :string, default: nil, aliases: '-c'

      def club_rank_top100
        Fifa::Game.club_rank_top100(
          options[:debug],
          options[:verbose],
          options[:platform],
          options[:club_name]
        )
      rescue => error
        Fifa::Utils::Log.error("Log path : #{Fifa::Utils::Log.log_path}\n")
        raise error
      end

      desc 'club_stats [-d|-v|-p|-c]', 'To get datas about a club'
      long_desc <<-LONGDESC
      The method 'club_stats' is used to get datas about a club

      > from: Lonny Antunes
      LONGDESC
      method_option :platform,  type: :string, default: nil, aliases: '-p'
      method_option :club_name, type: :string, default: nil, aliases: '-c'

      def club_stats
        Fifa::Game.club_stats(
          options[:debug],
          options[:verbose],
          options[:platform],
          options[:club_name]
        )
      rescue => error
        Fifa::Utils::Log.error("Log path : #{Fifa::Utils::Log.log_path}\n")
        raise error
      end

      desc 'club_matches_history [-d|-v|-p|-c]', 'To get the history of the last 10 matches'
      long_desc <<-LONGDESC
      The method 'club_matches_history' is used to get the history of the last 10 matches

      > from: Lonny Antunes
      LONGDESC
      method_option :platform,  type: :string, default: nil, aliases: '-p'
      method_option :club_name, type: :string, default: nil, aliases: '-c'

      def club_matches_history
        Fifa::Game.club_matches_history(
          options[:debug],
          options[:verbose],
          options[:platform],
          options[:club_name]
        )
      rescue => error
        Fifa::Utils::Log.error("Log path : #{Fifa::Utils::Log.log_path}\n")
        raise error
      end


      desc 'club_members [-d|-v|-p|-c]', 'To get members of a club'
      long_desc <<-LONGDESC
      The method 'club_members' is used to get members of a club

      > from: Lonny Antunes
      LONGDESC
      method_option :platform,    type: :string, default: nil, aliases: '-p'
      method_option :club_name,   type: :string, default: nil, aliases: '-c'

      def club_members
        Fifa::Game.club_members(
          options[:debug],
          options[:verbose],
          options[:platform],
          options[:club_name]
        )
      rescue => error
        Fifa::Utils::Log.error("Log path : #{Fifa::Utils::Log.log_path}\n")
        raise error
      end

      desc 'player_datas [-d|-v|-p|-c|-n]', 'To get datas about a player'
      long_desc <<-LONGDESC
      The method 'player_datas' is used to get datas about a player

      > from: Lonny Antunes
      LONGDESC
      method_option :platform,    type: :string, default: nil, aliases: '-p'
      method_option :club_name,   type: :string, default: nil, aliases: '-c'
      method_option :player_name, type: :string, default: nil, aliases: '-n'

      def player_datas
        Fifa::Game.player_datas(
          options[:debug],
          options[:verbose],
          options[:platform],
          options[:club_name],
          options[:player_name]
        )
      rescue => error
        Fifa::Utils::Log.error("Log path : #{Fifa::Utils::Log.log_path}\n")
        raise error
      end

      desc 'player_datas_top100 [-d|-v|-p|-c|-n]', 'To get datas about a player in the top 100'
      long_desc <<-LONGDESC
      The method 'player_datas_top100' is used to get datas about a player in the top 100

      > from: Lonny Antunes
      LONGDESC
      method_option :platform,    type: :string, default: nil, aliases: '-p'
      method_option :player_name, type: :string, default: nil, aliases: '-n'

      def player_datas_top100
        Fifa::Game.player_datas_top100(
          options[:debug],
          options[:verbose],
          options[:platform],
          options[:player_name]
        )
      rescue => error
        Fifa::Utils::Log.error("Log path : #{Fifa::Utils::Log.log_path}\n")
        raise error
      end
    end
  end
end
