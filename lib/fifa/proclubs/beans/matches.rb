module Fifa
  module Proclubs
    module Apis
      class Matches
        attr_accessor :lastMatch0,
                      :lastMatch1,
                      :lastMatch2,
                      :lastMatch3,
                      :lastMatch4,
                      :lastMatch5,
                      :lastMatch6,
                      :lastMatch7,
                      :lastMatch8,
                      :lastMatch9

        module RESULT
          WINS    = '2'.freeze
          TIES    = '1'.freeze
          LOSSES  = '0'.freeze
        end

        def initialize(lastMatch0, lastMatch1, lastMatch2, lastMatch3, lastMatch4, lastMatch5, lastMatch6, lastMatch7, lastMatch8, lastMatch9)
          @lastMatch0 = lastMatch0
          @lastMatch1 = lastMatch1
          @lastMatch2 = lastMatch2
          @lastMatch3 = lastMatch3
          @lastMatch4 = lastMatch4
          @lastMatch5 = lastMatch5
          @lastMatch6 = lastMatch6
          @lastMatch7 = lastMatch7
          @lastMatch8 = lastMatch8
          @lastMatch9 = lastMatch9
        end
      end
    end
  end
end
