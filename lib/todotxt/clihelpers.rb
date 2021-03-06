module Todotxt
  module CLIHelpers

    def format_todo(todo, number_padding=nil)
      line = todo.line.to_s
      if number_padding
        line = line.rjust number_padding
      end

      text = todo.to_s

      unless todo.done
        text.gsub! PRIORITY_REGEX do |p|
          case p[1]
          when "A"
            color = :red
          when "B"
            color = :yellow
          when "C"
            color = :green
          else
            color = :white
          end

          p.to_s.color(color)
        end

        text.gsub! PROJECT_REGEX, '\1'.color(:green)
        text.gsub! CONTEXT_REGEX, '\1'.color(:blue)
      else
        text = text.color(:black).bright
      end

      ret = ""

      ret << "#{line}. ".color(:black).bright
      ret << "#{text}"
    end

    def warn message=""
      puts "WARN: #{message}".color(:yellow)
    end

    def notice message=""
      puts "=> #{message}".color(:green)
    end

    def error message=""
      puts "ERROR: #{message}".color(:red)
    end

    def error_and_exit message =""
      error message
      exit
    end
  end
end
