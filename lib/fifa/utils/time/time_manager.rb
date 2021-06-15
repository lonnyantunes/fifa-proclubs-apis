module Fifa
  module Utils
    # noinspection ALL
    class TimeManager
      def initialize
        @initial_time = (Time.now.to_f * 1000).to_i
        @times = {}
      end

      @@instance = TimeManager.new

      def self.instance
        @@instance
      end

      def start(object, method, indentation = 0)
        tag = method

        current_time = (Time.now.to_f * 1000).to_i
        @times[tag] = [current_time, indentation]
        Log.success("#{TimeManager.get_indentation(indentation)}START - #{TimeManager.get_log_header(object, method)}") if Environment::Helper.debug?
      end

      def end(object, method)
        tag = method

        current_time = (Time.now.to_f * 1000).to_i
        Log.success("#{TimeManager.get_indentation(@times[tag][1])}END - #{TimeManager.get_log_header(object, method)} (#{current_time - @times[tag][0]}ms elapsed)\n") if Environment::Helper.debug?
      end

      def self.get_log_header(object, method)
        object_string = if object.class == Module
                          object
                        else
                          object.class
                        end
        "#{object_string}##{method}".bold
      end

      def self.get_indentation(indentation)
        "\t" * indentation
      end

      private_class_method :new
    end
  end
end
