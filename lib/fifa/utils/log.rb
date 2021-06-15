module Fifa
  module Utils
    module Log
      LOGS_FOLDER_NAME = 'logs'.freeze
      LOGS_VALIDATION_DURATION_IN_S = 604800

      def self.title(strings)
        line
        puts strings.red.bold
        line
        append_logs_file(strings)
      end

      def self.subtitle(strings)
        line
        puts strings.red
        line
        append_logs_file(strings)
      end

      def self.line
        puts "\n"
      end

      def self.verbose(object, method, strings, title = nil)
        object_string = if object.class == Module
                          object
                        else
                          object.class
                        end
        strings = strings.to_s # DO NOT REMOVE
        log_header = "#{object_string}##{method}"
        log_header += " - #{title}" unless title.nil?

        if Environment::Manager.instance.does_value_exist(Environment::Manager::VERBOSE) && Environment::Helper.verbose?
          puts log_header.yellow
          puts "#{strings.yellow}\n\n"
        end

        append_logs_file(strings, log_header)
      end

      def self.append_logs_file(content, log_header = nil)
        return unless Environment::Manager.instance.does_value_exist(Environment::Manager::TIMESTAMP)

        open(log_path, 'a') do |f|
          f.puts(log_header) unless log_header.nil?
          f.puts("#{content}\n\n")
        end
      end

      def self.method_arguments_values(object, method, binding)
        args = object.method(method).parameters.map {|arg| arg[1].to_s}
        verbose(object, method.to_s, args.map {|arg| "#{arg} = #{binding.local_variable_get(arg)}"}.join(', ').to_s, 'method arguments')
      end

      def self.log_path
        GemFolder::Helper.gem_file("log_#{Environment::Helper.timestamp}.txt", LOGS_FOLDER_NAME)
      end

      def self.clean_logs_files
        logs_folder_path = GemFolder::Helper.gem_folder(LOGS_FOLDER_NAME)
        files_paths_to_remove = []
        Dir[File.join(logs_folder_path, '*')].each do |file_path|
          next if File.directory? file_path

          file_name_creation_date = File.ctime(file_path).to_i
          time_now = Time.now.to_i
          timestamp_diff = time_now - file_name_creation_date

          if (LOGS_VALIDATION_DURATION_IN_S - timestamp_diff) < 0
            files_paths_to_remove.push(file_path)
          end
        end
        files_paths_to_remove.each do |file_path|
          File.delete(file_path)
        end
      end

      def self.error(strings)
        puts TTY::Box.error("More details :\n \n#{strings}",
                            :style => {
                                fg: :white,
                                bg: :black,
                                border: {
                                    fg: :white,
                                    bg: :red
                                }
                            }
        )
        append_logs_file(strings)

        exit
      end

      def self.warning(strings)
        puts TTY::Box.error("More details :\n \n#{strings}",
                            :style => {
                                fg: :white,
                                bg: :black,
                                border: {
                                    fg: :white,
                                    bg: :red
                                }
                            }
        )
        append_logs_file(strings)
      end

      def self.information(strings)
        puts TTY::Box.info("More details :\n \n#{strings}",
                           :style => {
                               fg: :white,
                               bg: :black,
                               border: {
                                   fg: :white,
                                   bg: :bright_blue
                               }
                           }
        )
        append_logs_file(strings)
      end

      def self.success(strings)
        puts TTY::Box.info("More details :\n \n#{strings}",
                           :style => {
                               fg: :white,
                               bg: :black,
                               border: {
                                   fg: :white,
                                   bg: :green
                               }
                           }
        )
        append_logs_file(strings)
      end
    end
  end
end
