module Fifa
  module Utils
    module Check
      # check if email is valid
      def self.email(email)
        valid = '[A-Za-z\d.+-]+' # Commonly encountered email address characters
        (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
      end

      # check if an homebrew framework is installed
      def self.homebrew_frameworks(framework_name)
        Fifa::Utils::Log.method_arguments_values(self, __method__, binding)

        framework_path = Fifa::Utils::Cli::Manager.run("which #{framework_name}", display_io: true, display_result: true, ignore_error: true).stdout
        if File.exist?(framework_path.strip)
          Fifa::Utils::Cli::Manager.run("brew upgrade #{framework_name}", ignore_error: true)
        else
          Fifa::Utils::Cli::Manager.run("brew install #{framework_name}")
        end
      end

      # check if a file and an extension exist
      def self.file_extension_and_path(file_path, expected_extension = '', concat_message = '')
        Fifa::Utils::Log.method_arguments_values(self, __method__, binding)

        if File.file?(file_path) && (File.extname(file_path) == expected_extension)
          true
        else
          Fifa::Utils::Log.warning("File path #{file_path} or expected extension #{expected_extension} are not valid !\n#{concat_message}")
          false
        end
      end

      def self.if_defined(value)
        Fifa::Utils.raise_exception("#{value} is not defined !") if defined?(value).nil?

        Fifa::Utils::Log.verbose(self, __method__, "value ===> #{value}")
      end

      def self.string(key, value)
        Check.nil(key, value)
        Check.empty(key, value)

        Fifa::Utils.raise_exception("Value for key '#{key}' must be a String class !") unless value.is_a?(String)
      end

      def self.boolean(key, value)
        Check.nil(key, value)
        Fifa::Utils.raise_exception("Value for key '#{key}' must be a Boolean class !") unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
      end

      def self.integer(key, value)
        Check.nil(key, value)
        Fifa::Utils.raise_exception("Value for key '#{key}' must be an Integer class !") unless value.is_a?(Integer)
      end

      def self.hash(key, value)
        Check.nil(key, value)
        Check.empty(key, value)
        Fifa::Utils.raise_exception("Value for key '#{key}' must be a Hash class !") unless value.is_a?(Hash)
      end

      def self.array(key, value)
        Check.nil(key, value)
        Check.empty(key, value)
        Fifa::Utils.raise_exception("Value for key '#{key}' must be an Array class !") unless value.is_a?(Array)
      end

      def self.file_path(key, value)
        Check.string(key, value)
        Fifa::Utils.raise_exception("Couldn't find file '#{key}' at path '#{value}'!") unless File.file?(value)
      end

      def self.directory_path(key, value)
        Check.string(key, value)
        Fifa::Utils.raise_exception("Couldn't find directory '#{key}' at path '#{value}'!") unless File.directory?(value)
      end

      def self.is_true(key, value)
        Check.nil(key, value)
        value.to_s == 'true'
      end

      def self.nil(key, value)
        Fifa::Utils.raise_exception("Value for key '#{key}' can't be nil' !") if value.nil?
      end

      def self.empty(key, value)
        Fifa::Utils.raise_exception("Value for key '#{key}' can't be empty !") if value.empty?
      end
    end
  end
end
