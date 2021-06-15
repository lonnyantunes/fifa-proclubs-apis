module Fifa
  module Utils
    module ExecShell
      module Constants
        module Methods
          BACKTICKS = 'backticks'.freeze
          SYSTEM = 'system'.freeze
          OPEN3 = 'open3'.freeze
          OPEN3_CAPTURE3 = 'open3_capture3'.freeze
        end

        module Status
          SUCCESS = 'success'.freeze
          FAIL = 'failure'.freeze
          UNKNOWN_COMMAND = 'unknown'.freeze
          WARN = 'warn'.freeze
        end
      end
    end
  end
end