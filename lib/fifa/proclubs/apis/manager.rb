module Fifa
  module Proclubs
    module Apis
      module Manager
        # List of top 100 ranked season clubs
        # @return array<club>
        def self.clubs_rank_top100(platform)
          array_club = []

          response = Helper.clubs_rank_top100(platform)

          if response
            response.each do |item|
              array_club.push(
                Club.new(
                  item['clubId'],
                  item['clubName'],
                  item['seasons'],
                  item['rankingPoints'],
                  item['bestDivision'],
                  item['currentDivision'],
                  item['titlesWon'],
                  item['leaguesWon'],
                  item['totalGames'],
                  item['wins'],
                  item['ties'],
                  item['losses'],
                  item['goals'],
                  item['goalsAgainst'],
                  item['averageGoalsPerGame'],
                  item['averageGoalsAgainstPerGame']
                )
              )
              sort_by_ranking_ascending(array_club)
            end
          else
            error_message_handler = ErrorMessageHandler.error_handler(ErrorMessageHandler::TOP100_NO_CLUBS % [platform])
          end

          Apis::Result.new(error_message_handler, array_club)
        end

        # Rank of a club from the top 100 ranked season clubs
        # @return club
        def self.club_rank_top100(platform, club_name)
          club = club_search(platform, club_name)
          if club
            result = clubs_rank_top100(platform)

            if result.error_message_handler
              error_message_handler = result.error_message_handler
            else
              array_clubs_rank = result.obj_result
              club = array_clubs_rank&.find { |obj| obj.clubId == club.clubId }
              if club
                Fifa::Utils::Log.success "#{club.place} -> '#{club_name}' (#{platform})"
              else
                error_message_handler = ErrorMessageHandler.error_handler(ErrorMessageHandler::TOP100_CLUB_DOESNT_EXIST % [platform, club_name])
              end
            end
          else
            error_message_handler = ErrorMessageHandler.error_handler(ErrorMessageHandler::CLUB_NOT_FOUND % [platform, club_name])
          end

          Apis::Result.new(error_message_handler, club)
        end

        # Stats about a club
        # @return club
        def self.club_stats(platform, club_name)
          result = club_id_by_name(platform, club_name)

          if result.error_message_handler
            error_message_handler = result.error_message_handler
          else
            club_id = result.obj_result
            response = Helper.club_stats(platform, club_id)
            if response
              club = Club.new(
                response['clubId'],
                nil,
                response['seasons'],
                response['rankingPoints'],
                response['bestDivision'],
                nil,
                response['titlesWon'],
                response['leaguesWon'],
                response['totalGames'],
                response['wins'],
                response['ties'],
                response['losses'],
                response['alltimeGoals'],
                response['alltimeGoalsAgainst'],
                nil,
                nil
              )

              club.matches = Matches.new(
                response['lastMatch0'],
                response['lastMatch1'],
                response['lastMatch2'],
                response['lastMatch3'],
                response['lastMatch4'],
                response['lastMatch5'],
                response['lastMatch6'],
                response['lastMatch7'],
                response['lastMatch8'],
                response['lastMatch9']
              )
            else
              error_message_handler = ErrorMessageHandler.error_handler(ErrorMessageHandler::CLUB_STATS_NOT_FOUND % [platform, club_name])
            end
          end

          Apis::Result.new(error_message_handler, club)
        end

        def self.club_matches_history(platform, club_name)
          result = club_stats(platform, club_name)

          if result.error_message_handler
            error_message = "#{ErrorMessageHandler::CLUB_MATCHES_HISTORY_NOT_FOUND % [platform, club_name]}\nRoot cause -> #{result.error_message_handler}"
            error_message_handler = ErrorMessageHandler.error_handler(error_message)
            Apis::Result.new(error_message_handler, nil)
          else
            club = result.obj_result
            Apis::Result.new(nil, club.matches)
          end
        end

        def self.club_members(platform, club_name)
          result = club_id_by_name(platform, club_name)

          if result.error_message_handler
            error_message_handler = result.error_message_handler
          else
            club_id = result.obj_result
            club_members_stats = members_club_stats(platform, club_id)[0]

            unless club_members_stats
              error_message_handler = ErrorMessageHandler.error_handler(ErrorMessageHandler::ERROR_CLUB_MEMBERS_STATS % [platform, club.clubName])
            end
          end

          Apis::Result.new(error_message_handler, club_members_stats)
        end

        def self.player_datas(platform, club_name, player_name)
          result = club_id_by_name(platform, club_name)

          if result.error_message_handler
            error_message_handler = result.error_message_handler
          else
            club_id = result.obj_result
            members_career_stats = members_career_stats(platform, club_id)[0]
            members_club_stats = members_club_stats(platform, club_id)[0]

            player_career_stats = members_career_stats.select { |member| member.name == player_name }.first
            player_club_stats = members_club_stats.select { |member| member.name == player_name }.first

            member = nil
            error_career_stats = nil
            error_club_stats = nil
            error_player_not_found = ErrorMessageHandler::PLAYER_NOT_FOUND_IN_CLUB % [player_name, club_name]

            if player_career_stats.nil?
              error_career_stats = ErrorMessageHandler::ERROR_CAREER_STATS % [error_player_not_found]
            else
              member = Member.new(
                player_career_stats.name,
                player_career_stats,
                nil
              )
            end
            if player_club_stats.nil?
              error_club_stats = ErrorMessageHandler::ERROR_CLUB_STATS % [error_player_not_found]
            else
              if member
                member.memberClub = player_club_stats
              else
                player_club_stats.clubName = club_name
                member = Member.new(
                  player_name,
                  nil,
                  player_club_stats
                )
              end
            end

            error_message = error_career_stats if error_career_stats
            error_message ? error_message += "\n#{error_club_stats}" : error_club_stats if error_club_stats
            error_message_handler = ErrorMessageHandler.error_handler(error_message) if error_message
          end

          Apis::Result.new(error_message_handler, member)
        end

        def self.player_datas_top100(platform, player_name)
          player_club_name = nil
          player_club_place = nil

          result = clubs_rank_top100(platform)

          if result.error_message_handler
            error_message_handler = result.error_message_handler
          else
            array_clubs_rank = result.obj_result
            array_clubs_rank.each do |club|
              response = Helper.club_member_stats(platform, club.clubId)

              if response
                unless response["members"].nil?
                  player = response["members"]&.find { |obj| obj["name"] == player_name }
                  if !player.nil? && player["name"] == player_name
                    player_name = player["name"]

                    player_club_name = club.clubName
                    player_club_place = club.place
                    Fifa::Utils::Log.information("Player : #{player_name} | Club n°#{player_club_place} : #{player_club_name}")
                    break
                  end
                end
              else
                ErrorMessageHandler.error_handler(ErrorMessageHandler::ERROR_CLUB_MEMBER_STATS % [platform, club.clubName, player_name])
              end
            end
          end

          if player_club_name.nil? && player_club_place.nil?
            error_message_handler = ErrorMessageHandler.error_handler(ErrorMessageHandler::TOP100_PLAYER_NOT_FOUND % [player_name])
          end

          Apis::Result.new(error_message_handler, [player_name, player_club_name, player_club_place])
        end

        private

        def self.sort_by_ranking_ascending(array_club)
          array_club.sort { |a, b| b.rankingPoints <=> a.rankingPoints }

          array_club.each_with_index do |item, index|
            item.place = index + 1
          end

          array_club
        end

        # List of clubs filtered by name
        # @return array<club>
        def self.club_search(platform, club_name)
          club = nil

          response = Helper.club_search(platform, club_name)

          response&.each do |item|
            next unless club_name == item['name']

            club = Club.new(
              item['clubId'],
              item['name'],
              item['seasons'],
              item['rankingPoints'],
              item['bestDivision'],
              nil,
              item['titlesWon'],
              item['leaguesWon'],
              item['totalGames'],
              item['wins'],
              item['ties'],
              item['losses'],
              item['alltimeGoals'],
              item['alltimeGoalsAgainst'],
              nil,
              nil
            )

            club.matches = Matches.new(
              item['lastMatch0'],
              item['lastMatch1'],
              item['lastMatch2'],
              item['lastMatch3'],
              item['lastMatch4'],
              item['lastMatch5'],
              item['lastMatch6'],
              item['lastMatch7'],
              item['lastMatch8'],
              item['lastMatch9']
            )
          end

          club
        end

        def self.club_id_by_name(platform, club_name)
          club = club_search(platform, club_name)

          if club
            Apis::Result.new(nil, club.clubId)
          else
            error_message_handler = ErrorMessageHandler.error_handler(ErrorMessageHandler::CLUB_NOT_FOUND % [platform, club_name])
            Apis::Result.new(error_message_handler, nil)
          end
        end

        # list of members with statistics in the career
        def self.members_career_stats(platform, club_id)
          array_members = []
          positions = nil

          response = Helper.club_member_career_stats(platform, club_id)
          members = response["members"]

          unless members.nil?
            members.each do |item|
              array_members.push(
                MemberCareerStats.new(
                  item["name"],
                  item["ratingAve"],
                  item["favoritePosition"],
                  item["gamesPlayed"],
                  item["manOfTheMatch"],
                  item["goals"],
                  item["assists"]
                )
              )
            end

            position_count = response["positionCount"]
            positions = PositionCount.new(
              position_count["midfielder"],
              position_count["goalkeeper"],
              position_count["forward"],
              position_count["defender"]
            )
          end

          [array_members, positions]
        end

        # list of members with statistics in the club.rb
        def self.members_club_stats(platform, club_id)
          array_members = []
          positions = nil

          response = Helper.club_member_stats(platform, club_id)
          members = response["members"]

          unless members.nil?
            members.each do |item|
              array_members.push(
                MemberClubStats.new(
                  item["name"],
                  item["proName"],
                  item["proOverall"],
                  item["favoritePosition"],
                  item["gamesPlayed"],
                  item["manOfTheMatch"],
                  item["goals"],
                  item["assists"],
                  item["winRate"],
                  item["shotSuccessRate"],
                  item["passesMade"],
                  item["passSuccessRate"],
                  item["tacklesMade"],
                  item["tackleSuccessRate"],
                  item["redCards"],
                  item["cleanSheetsDef"],
                  item["cleanSheetsGK"]
                )
              )
            end

            position_count = response["positionCount"]
            positions = PositionCount.new(
              position_count["midfielder"],
              position_count["goalkeeper"],
              position_count["forward"],
              position_count["defender"]
            )
          end


          [array_members, positions]
        end
      end
    end
  end
end

