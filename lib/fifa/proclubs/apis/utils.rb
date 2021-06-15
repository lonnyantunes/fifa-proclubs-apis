module Fifa
  module Proclubs
    module Apis
      module Utils
        def self.check_platform(key, value)
          Fifa::Utils::Check.string(key, value)

          unless Helper.platforms.find { |platform| platform == value }
            Fifa::Utils.raise_exception("Platform '#{value}' not found in #{Helper.platforms} !")
          end
        end
      end
    end
  end
end