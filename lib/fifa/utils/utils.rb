require 'net/http'
require 'net/https'
require 'uri'
require 'cgi'
require 'json'
require 'open3'
require 'pastel'
require 'date'
require 'fileutils'
require 'time'
require 'tty-prompt'
require 'tty-box'
require 'artii'
require 'gemoji'
require 'pstore'

require_relative 'check'
require_relative 'dialog_utils'
require_relative 'log'
require_relative 'pastel_singleton'
require_relative 'string'

require_relative 'environment/environment_manager'
require_relative 'environment/environment_helper'
require_relative 'environment/environment_setup'

require_relative 'exec-shell/constants'
require_relative 'exec-shell/beans/results'
require_relative 'exec-shell/manager'

require_relative 'gem_folder/gem_folder_helper'

require_relative 'http/http'
require_relative 'http/http_response'

require_relative 'time/beans/time_emoji'
require_relative 'time/time_manager'
require_relative 'time/time_utils'

module Fifa
  module Utils
    # @param [String]  file_path
    # @return [JSON]
    def self.parse_json(file_path)
      Log.method_arguments_values(self, __method__, binding)

      JSON.parse(File.read(file_path))
    end

    def self.raise_exception(message)
      message = "Missing argument message !" if message.nil? || message == ''
      Fifa::Utils::Log.error(message)
    end

    def self.catch_error_from(&block)
      begin
        block&.call
      rescue exception
        Fifa::Utils::Log.error(exception.message)
      end
    end

    def self.escape_characters_in_string(str)
      Check.string("str", str)

      pattern = /(\'|\"|\.|\*|\/|\-|\\|\)|\$|\+|\(|\^|\?|\!|\~|\`)/
      str.gsub(pattern) { |match| '\\' + match }
    end

    def self.banner(text_banner: '', font: 'slant')
      artii = Artii::Base.new(:font => font)
      puts artii.asciify(text_banner)
    end

    def self.values_from_file_by_regex(file_path: nil, regex: nil)
      Check.file_path('file_path', file_path)
      result = File.open(file_path).read()
      result.delete("\r").scan(Regexp.new(regex)).to_h
    end

    # Example :
    # append_to_string(templated_key: "Number is %{d}, type is %{s}", values_to_append: {d: 13, s: "cat"})
    # => "Number is 13, type is cat"
    def self.append_to_string(templated_key: nil, values_to_append: {})
      Check.string('templated_key', templated_key)
      Check.hash('values_to_append', values_to_append)
      templated_key % values_to_append
    end

    # Example :
    # rename_files_recursively("CMN_", "CMN_", "")
    def self.rename_files_recursively(string_to_match, string_to_replace, new_string)
      Dir.glob("./**/*#{string_to_match}*").each do |file|
        new_file = file.gsub(string_to_replace, new_string)
        Fifa::Utils::Log.information("file ==> #{file}\nnew_file ===> #{new_file}")

        File.rename(file, new_file)
      end
    end

    def self.delete_files_recursively(string_to_match)
      Dir.glob("./**/*#{string_to_match}*").each do |file|
        Fifa::Utils::Log.information("file ==> #{file}")
        File.delete(file)
      end
    end

    def self.uri?(string)
      uri = URI.parse(string)
      %w(http https).include?(uri.scheme)
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end
  end
end
