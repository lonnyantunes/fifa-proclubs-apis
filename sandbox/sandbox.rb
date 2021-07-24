require 'fifa/game'

def self.display_result(topic, result)
  if result.error_message_handler
    puts "#{topic} :\n#{result.error_message_handler}"
  else
    puts "#{topic} :\n#{result.obj_result}"
  end
end

is_debug = true
is_verbose = false

Fifa::Utils::Environment::Setup.init(
  'fifa-proclubs-apis',
  is_debug,
  is_verbose,
  nil,
  '20210724120000')

platform = Fifa::Proclubs::Apis::Constants::PLATFORMS::PLAYSTATION_4
club_name = "Massilia    fc"
player_name = "lonnycha"


display_result('clubs_rank_top100', Fifa::Proclubs::Apis.clubs_rank_top100(platform))
display_result('club_rank_top100', Fifa::Proclubs::Apis.club_rank_top100(platform, club_name))
display_result('club_stats', Fifa::Proclubs::Apis.club_stats(platform, club_name))
display_result('club_matches_history', Fifa::Proclubs::Apis.club_matches_history(platform, club_name))
display_result('club_members', Fifa::Proclubs::Apis.club_members(platform, club_name))
display_result('player_datas', Fifa::Proclubs::Apis.player_datas(platform, club_name, player_name))
display_result('player_datas_top100', Fifa::Proclubs::Apis.player_datas_top100(platform, player_name))
