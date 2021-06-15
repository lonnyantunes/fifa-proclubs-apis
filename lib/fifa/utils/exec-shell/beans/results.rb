module Fifa
  module Utils
    module ExecShell
      class Results
        attr_accessor :command, :stdout, :stderr, :status

        # Create the object
        def initialize(command = nil, stdout = nil, stderr = nil, status = '')
          Log.method_arguments_values(self, __method__, binding)
          Fifa::Utils::Check.string('command', command)
          Fifa::Utils::Check.nil('stdout', stdout)
          Fifa::Utils::Check.nil('stderr', stderr)
          Fifa::Utils::Check.string('status', status)

          @command = command
          @stdout = stdout
          @stderr = stderr
          @status = status
        end

        def message(display_result: true, ignore_error: false)
          # we get the result status to display messages

          case @status
          when Fifa::Utils::Cli::Constants::Status::SUCCESS
            Fifa::Utils::Log.success(@stdout) if display_result && !@stdout.empty?
          when Fifa::Utils::Cli::Constants::Status::FAIL
            message = 'Command executed with failure !'
            message += "\n\n#{@stderr}" if display_result && !@stderr.empty?

            ignore_error ? Fifa::Utils::Log.warning(message) : Fifa::Utils::Log.error(message)
          when Fifa::Utils::Cli::Constants::Status::UNKNOWN_COMMAND
            Fifa::Utils::Log.error("Unknown Command : #{@command}")
          else
            Fifa::Utils::Log.error('Unexpected error : status result not defined !')
          end
        end

        def short_message(tool: '')
          Fifa::Utils::Check.string('tool', tool)

          if @status == Fifa::Utils::Cli::Constants::Status::SUCCESS
            Fifa::Utils::Log.success("#{tool} task was run with success")
          else
            Fifa::Utils::Log.warning("#{tool} task was run with errors")
          end
        end
      end
    end
  end
end

