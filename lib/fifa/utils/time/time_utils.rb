module Fifa
  module Utils
    module TimeUtils
      def self.emojis_from_time(current_time: Time.now)
        # Set Time hour if it is up to 12 (set PM to AM)
        if current_time.hour > 12 || current_time.hour == 0
          # if current_time.hour is 0, convert it to 12
          final_hour = current_time.hour == 0 ? 12 : current_time.hour

          current_time = Time.new(current_time.year,
                                  current_time.month,
                                  current_time.day,
                                  Time.parse("#{final_hour}:00").strftime('%l'),
                                  current_time.min,
                                  current_time.sec
          )
        end

        # Create an array of emojis related to the time
        array_time_emoji = []
        (1..12).to_a.each do |hour|
          array_time_emoji.push(TimeEmoji.new(hour: hour))
          array_time_emoji.push(TimeEmoji.new(hour: hour, is_half_hour: true))
        end

        # Find the emoji related to the current_time
        emoji = nil
        array_time_emoji.each do |time_emoji|
          next unless current_time.between?(
              Time.new(current_time.year, current_time.month, current_time.day, time_emoji.hour, time_emoji.begin_minutes, 0),
              Time.new(current_time.year, current_time.month, current_time.day, time_emoji.hour, time_emoji.end_minutes, 59)
          )

            emoji = time_emoji.emoji_raw
            break
        end

        emoji
      end

      def self.test_all_cases(is_half_hour = false)
        end_minutes = !is_half_hour ? 29 : 59

        (0..23).to_a.each do |hour|
          time = Time.new(2020,02,23,hour,end_minutes,00)
          puts "#{Fifa::Utils::TimeUtils.emojis_from_time(current_time: time)} : #{hour}"
        end
      end
    end
  end
end