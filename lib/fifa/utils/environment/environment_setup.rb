module Fifa
  module Utils
    module Environment
      module Setup
        def self.init(lib_name, is_debug, verbose, method_name = nil, timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S'), ci: true)
          return if Manager.instance.does_value_exist(Manager::LIB_NAME)

          system('clear') || system('cls')

          Manager.instance.set_value(Manager::LIB_NAME, lib_name) # DO NOT DELETE - Keep this order
          Manager.instance.set_value(Manager::METHOD_NAME, method_name) unless method_name.nil? # DO NOT DELETE - Keep this order
          Manager.instance.set_value(Manager::VERBOSE, verbose) # Keep this order
          Manager.instance.set_value(Manager::TIMESTAMP, timestamp)
          Manager.instance.set_value(Manager::DEBUG, is_debug)

          Log.clean_logs_files
        end
      end
    end
  end
end