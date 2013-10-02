module Utilities
  class << self
    CFG_FILE = File.join(ENV['HOME'], ".#{File.basename($0)}")

    def get_pinboard_credentials
      if File.exists?(CFG_FILE)
        puts "Using config file '#{CFG_FILE}'"
        user, pass = File.new(CFG_FILE).gets.chomp.split(':', 2)
      else
        begin
          require 'highline'
          hl = HighLine.new
          user = hl.ask('Enter Pinboard username: ')
          pass = hl.ask('Enter Pinboard password: ') { |q| q.echo = "*" }
        rescue LoadError
          puts "Can't find config file '#{CFG_FILE}' and you don't seem to have HighLine installed. Aborting!"
          exit 1
        end
      end
      [user, pass]
    end
  end
end
