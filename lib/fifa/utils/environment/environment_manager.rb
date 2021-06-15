module Fifa
  module Utils
    module Environment
      class Manager
        DEBUG = :debug
        VERBOSE = :verbose
        LIB_NAME = :lib_name
        METHOD_NAME = :method_name
        TIMESTAMP = :initial_time

        def initialize
          @values = {}
        end

        @@instance = Manager.new

        def self.instance
          @@instance
        end

        def does_value_exist(name)
          @values.key?(name)
        end

        def set_value(name, value)
          @values[name] = value
          Log.verbose(self, __method__, "#{name} = '#{value}'")
        end

        def get_value(name)
          if mandatory_values_list.include?(name) && !does_value_exist(name)
            Log.error("CAUTION : you can\\'t continue to use the lib fifa-proclubs-apis without having called the method Fifa::Utils::Environment::Setup.init at the beginning of your script! (#{name})".bold)
            return
          end
          @values[name]
        end

        def mandatory_values_list
          [DEBUG, VERBOSE, LIB_NAME, TIMESTAMP]
        end

        private_class_method :new
      end
    end
  end
end