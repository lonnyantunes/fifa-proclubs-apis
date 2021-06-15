module Fifa
  module Proclubs
    module Apis
      class Member
        attr_accessor :name, :memberCareer, :memberClub

        def initialize(name, memberCareer, memberClub)
          @name = name
          @memberCareer = memberCareer
          @memberClub = memberClub
        end
      end
    end
  end
end
