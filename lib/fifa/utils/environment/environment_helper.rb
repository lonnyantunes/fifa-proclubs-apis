module Fifa
  module Utils
    module Environment
      module Helper
        def self.debug?
          Manager.instance.get_value(Manager::DEBUG)
        end

        def self.verbose?
          Manager.instance.get_value(Manager::VERBOSE)
        end

        def self.lib_name
          Manager.instance.get_value(Manager::LIB_NAME)
        end

        def self.method_name
          Manager.instance.get_value(Manager::METHOD_NAME)
        end

        def self.timestamp
          Manager.instance.get_value(Manager::TIMESTAMP)
        end
      end
    end
  end
end