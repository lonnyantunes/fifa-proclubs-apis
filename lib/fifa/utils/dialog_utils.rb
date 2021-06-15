module Fifa
  module Utils
    module DialogUtils
      def self.ask_something(message = nil)
        puts message if !message.nil? && !message.empty?
        print('> ')
        STDIN.flush
        STDIN.gets.chomp
      end

      def self.ask_confirmation(message)
        is_answer_ok = false
        final_answer = nil
        until is_answer_ok
          puts message + ' (y/n)'.bold
          print('> ')
          STDIN.flush
          answer = STDIN.gets.chomp
          if answer.nil? || (!answer.casecmp('y').zero? && !answer.casecmp('n').zero?)
            Log.warning('I did not understand your answer. Try again please.')
          else
            final_answer = answer.downcase
            is_answer_ok = true
          end
        end
        final_answer == 'y'
      end

      def self.ask_number(message = nil, min, max)
        is_answer_ok = false
        final_answer = nil
        until is_answer_ok
          puts message if !message.nil? && !message.empty?
          print('> ')
          STDIN.flush
          answer = STDIN.gets.chomp.to_i
          if !answer.is_a?(Numeric)
            Log.warning('You should type a number')
          elsif answer >= min && answer <= max
            final_answer = answer
            is_answer_ok = true
          else
            Log.warning("Your number has to be between #{min} and #{max}")
          end
        end
        final_answer
      end

      def self.ask_choice(message, choices_hash: {}, choices_array: [])
        choices_final = choices_hash
        if choices_hash.empty?
          choices_final = {}
          choices_array.each do |choices_array_item|
            choices_final[choices_array_item] = choices_array_item
          end
        end

        message += "\n"
        index = 1
        map_choices = {}
        choices_final.each do |key, value|
          message += "\t#{index}. #{value}\n"
          map_choices[index] = key
          index += 1
        end

        is_answer_ok = false
        final_answer = nil
        until is_answer_ok
          puts message

          print('> ')
          STDIN.flush
          answer = STDIN.gets.chomp.to_i
          if !answer.is_a?(Numeric) || answer < 1 || answer > choices_final.length
            Log.warning("You should pick a choice in #{map_choices.keys}")
          else
            final_answer = map_choices[answer]
            is_answer_ok = true
          end
        end
        final_answer
      end

      def self.ask_press_enter(message)
        puts message
        STDIN.flush
        STDIN.gets.chomp
      end
    end
  end
end