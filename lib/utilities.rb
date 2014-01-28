require 'getoptlong'

module Utilities
  class << self
    PROGRAM_NAME = File.basename($0)
    CFG_FILE = File.join(ENV['HOME'], ".#{PROGRAM_NAME}")

    def get_options
      get_credentials.merge(parse_options)
    end

    private
    def get_credentials
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
      {:user => user, :pass => pass}
    end

    def parse_options
      options = {}
      opts = GetoptLong.new(
        ['--dry-run', '-n', GetoptLong::NO_ARGUMENT],
        ['--http-proxy', '-p', GetoptLong::REQUIRED_ARGUMENT],
        ['--help', '-h', GetoptLong::NO_ARGUMENT]
      )

      opts.each do |opt, arg|
        case opt
        when '--help'
          puts <<EOF
#{PROGRAM_NAME} [OPTIONS]

-h, --help:
   show help

-d, --dry-run:
   only log outdated links without deleting them

-p, --http-proxy:
   specify an HTTP proxy
EOF
          exit 0
        when '--dry-run'
          options[:dry_run] = true
        when '--http-proxy'
          options[:http_proxy] = true
          uri = URI.parse(arg)
          options[:proxy_host] = uri.host
          options[:proxy_port] = uri.port || 8080
          options[:proxy_user] = uri.user
          options[:proxy_pass] = uri.password
        end
      end
      # if the first arg is nil, Net::HTTP:Proxy returns a normal Net::HTTP object
      options[:http_client] = Net::HTTP::Proxy(*options.values_at(:proxy_host,
                                                                  :proxy_port,
                                                                  :proxy_user,
                                                                  :proxy_pass))
      options
    end
  end
end
