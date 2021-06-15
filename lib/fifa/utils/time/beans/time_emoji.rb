module Fifa
  module Utils
    class TimeEmoji
      attr_accessor :emoji_raw, :hour, :begin_minutes, :end_minutes

      def initialize(hour: 1, is_half_hour: false)
        @emoji_raw = Emoji.find_by_alias("clock#{hour}#{'30' if is_half_hour}").raw

        @hour = hour
        @begin_minutes = !is_half_hour ? '00' : 30
        @end_minutes = !is_half_hour ? 29 : 59
      end
    end
  end
end