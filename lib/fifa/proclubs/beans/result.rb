module Fifa
  module Proclubs
    module Apis
      class Result
        attr_accessor :error_message_handler, :obj_result

        def initialize(error_message_handler, obj_result)
          @error_message_handler = error_message_handler
          @obj_result = obj_result
        end
      end
    end
  end
end
