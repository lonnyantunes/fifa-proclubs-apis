class String
  UNICODE_NEWLINE = '\u000D'.freeze
  UNICODE_TABULATION = '\u0009'.freeze
  UNICODE_QUOTE = '\u0027'.freeze

  # Get a boolean value from 'true' or 'false' string based value
  def to_bool
    case self
    when nil, /\A(false|f|no|n|0|)\z/i, false
      false
    else
      true
    end
  end

  def colorize(code, suffix = 0)
    string = self

    begin
      seq = "\033[" + code.to_s + 'm'
      match = string.match(/^(\033\[([\d;]+)m)*/)
      seq_pos = match.end(0)
      string = string[0...seq_pos] + seq + string[seq_pos..-1]

      string += "\033[#{suffix}m" unless string =~ /\033\[#{suffix}m$/
    rescue ArgumentError => e
      # Do nothing on the string
      string = self
    end

    string
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end

  def bold
    colorize(1, 22)
  end

  def underline
    colorize(4, 24)
  end

  def underline
    colorize(4, 24)
  end

  def strikethrough
    colorize(9, 29)
  end
end
