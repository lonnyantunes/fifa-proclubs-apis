module Fifa
  module Utils
    module HTTP
      class Response
        attr_accessor :code, :body

        def initialize(code, body)
          @code = code
          @body = body
        end

        def to_s
          "#{code}\n#{body}"
        end
      end
    end
  end
end