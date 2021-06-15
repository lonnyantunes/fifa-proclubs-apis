module Fifa
  module Proclubs
    module Apis
      class PositionCount
        attr_accessor :midfielder, :goalkeeper, :forward, :defender

        def initialize(midfielder, goalkeeper, forward, defender)
          @midfielder = midfielder
          @goalkeeper = goalkeeper
          @forward = forward
          @defender = defender
        end
      end
    end
  end
end
