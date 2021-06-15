module Fifa
  module Utils
    module ExecShell
      module Manager
        def self.run(command, display_io: false, display_result: false, cli_method: nil, ignore_error: false)
          Log.method_arguments_values(self, __method__, binding)
          Fifa::Utils::Check.string('command', command)

          stdout_result = ''
          stderr_result = ''
          status_result = ''

          # if no cli_methods as parameter, it is defined from display_io and display_result values
          if cli_method.nil?
            if !display_io && !display_result
              cli_method = Fifa::Utils::Cli::Constants::Methods::OPEN3_CAPTURE3
            elsif !display_io && display_result
              cli_method = Fifa::Utils::Cli::Constants::Methods::OPEN3_CAPTURE3
            elsif display_io && !display_result
              cli_method = Fifa::Utils::Cli::Constants::Methods::SYSTEM
            elsif display_io && display_result
              cli_method = Fifa::Utils::Cli::Constants::Methods::OPEN3
            end
          end

          # related to the cli_method defined, we call a method to execute the command
          case cli_method
          when Fifa::Utils::Cli::Constants::Methods::OPEN3
            status_result, stderr_result, stdout_result = open3_call(command, display_io, stderr_result, stdout_result)
          when Fifa::Utils::Cli::Constants::Methods::OPEN3_CAPTURE3
            status_result, stderr_result, stdout_result = open3_capture3_call(command, stdout_result)
          when Fifa::Utils::Cli::Constants::Methods::BACKTICKS
            status_result, stderr_result, stdout_result = backticks_call(command, stdout_result)
          when Fifa::Utils::Cli::Constants::Methods::SYSTEM
            status_result = system_call(command)
          else
            Fifa::Utils::Log.error("Wrong Cli methods '#{cli_method} !")
          end

          Log.verbose(self, __method__, stderr_result, 'stderr_result') unless stderr_result.empty?
          Log.verbose(self, __method__, status_result, 'status_result') unless status_result.to_s.empty?

          result = Fifa::Utils::Cli::Results.new(command, stdout_result, stderr_result, status_result)
          result.message(display_result: display_result, ignore_error: ignore_error)

          result
        end

        private

        # Open3 :
        # it can gives outputs on real time or at the end of the CLI execution
        # it gives outputs, errors and status
        def self.open3_call(command, display_io, stderr_result, stdout_result)
          Log.method_arguments_values(self, __method__, binding)

          status_result = Fifa::Utils::Cli::Constants::Status::FAIL
          Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
            if display_io
              while line = stdout.gets do
                puts(line)
                stdout_result += line
              end

              while line = stderr.gets do
                puts(line)
                stderr_result += line
              end
            else
              stdout_result = stdout.read
              stderr_result = stderr.read
            end

            status_result = case wait_thr.value.exitstatus
                            when 0
                              Fifa::Utils::Cli::Constants::Status::SUCCESS
                            when 1
                              Fifa::Utils::Cli::Constants::Status::FAIL
                            else
                              Fifa::Utils::Cli::Constants::Status::UNKNOWN_COMMAND
                            end
          end

          [status_result, stderr_result, stdout_result]
        end

        # Open3.capture3 :
        # it doesn't give outputs on real time but it gives outputs at the end of the CLI execution (empty, not empty, raised error)
        def self.open3_capture3_call(command, stdout_result)
          Log.method_arguments_values(self, __method__, binding)

          begin
            stdout_result, stderr_result, status_result = Open3.capture3(command)
            status_result = case status_result.exitstatus
                            when 0
                              Fifa::Utils::Cli::Constants::Status::SUCCESS
                            when 1
                              Fifa::Utils::Cli::Constants::Status::FAIL
                            else
                              Fifa::Utils::Cli::Constants::Status::UNKNOWN_COMMAND
                            end
          rescue
            stderr_result = stdout_result
            status_result = Fifa::Utils::Cli::Constants::Status::FAIL
          end

          [status_result, stderr_result, stdout_result]
        end

        # backticks :
        # it doesn't give outputs on real time but it gives outputs at the end of the CLI execution (empty, not empty, raised error)
        def self.backticks_call(command, stdout_result)
          Log.method_arguments_values(self, __method__, binding)

          begin
            stdout_result = `#{command} 2>&1`

            status_result = if stdout_result.include?('command not found')
                              stderr_result = stdout_result
                              Fifa::Utils::Cli::Constants::Status::UNKNOWN_COMMAND
                            else
                              Fifa::Utils::Cli::Constants::Status::SUCCESS
                            end
          rescue
            stderr_result = stdout_result
            status_result = Fifa::Utils::Cli::Constants::Status::FAIL
          end

          [status_result, stderr_result, stdout_result]
        end

        # system :
        # it gives outputs on real time but it gives a result status at the end of the CLI execution (false, true or nil)
        def self.system_call(command)
          Log.method_arguments_values(self, __method__, binding)

          system_result = system(command)
          status_result = if system_result == false
                            Fifa::Utils::Cli::Constants::Status::FAIL
                          elsif system_result == true
                            Fifa::Utils::Cli::Constants::Status::SUCCESS
                          else
                            Fifa::Utils::Cli::Constants::Status::UNKNOWN_COMMAND
                          end

          status_result
        end
      end
      end
  end
end