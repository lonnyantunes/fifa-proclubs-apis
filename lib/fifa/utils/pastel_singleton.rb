module Fifa
  module Utils
    class PastelSingleton
      def initialize
        @pastel_instance = Pastel.new
      end

      @@instance = PastelSingleton.new

      def self.instance
        @@instance
      end

      def decorate(message, *colors)
        @pastel_instance.decorate(message, *colors)
      end

      private_class_method :new
    end
  end
end