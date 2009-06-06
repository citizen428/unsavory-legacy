#!/usr/bin/ruby

#require 'rubygems' # uncomment if you can't/don't want to set $RUBYOPT
require 'highline'
require 'httparty'
require 'net/http'

class Delicious
  include HTTParty
  base_uri 'https://api.del.icio.us/v1'
  headers "User-Agent" => "Unsavory 0.1"
  
  API_METHODS = { 
    :all => '/posts/all', 
    :delete => '/posts/delete?url='} 
 
  def initialize(user, password)
    @options = {:basic_auth => {:username => user, :password => password}}
  end
  
  def get_all
    self.class.get(API_METHODS[:all], @options)
  end
  
  def delete(url)
    self.class.get(API_METHODS[:delete]+url, @options)
  end
end

hl = HighLine.new
user = hl.ask('Enter Delicious username: ')
pass = hl.ask('Enter Delicious password: ') { |q| q.echo = "*" }

delicious = Delicious.new(user, pass)
urls = []

begin
  delicious.get_all['posts']['post'].each { |post| urls << post['href'] }
rescue => e
  puts %{
  I couldn't get your posts from Delicious.
  Did you enter the right username/password?
  }
  exit 1
end

puts "\n#{user} has #{urls.length} bookmarks."

urls.each_with_index do |url, idx|
  print "Processing URL #%04d: " % (idx+1)
  uri = URI.parse(url)
  response = nil
  
  begin
    Net::HTTP.start(uri.host, uri.port) do |http|
      # Love bandwidth, give HEAD
      response = http.head(uri.path.size > 0 ? uri.path : "/")
    end
  rescue => e 
    puts "#{e.message} - #{url}" 
    next
  end
    
  puts case response.code
    when '200' then 'OK'
    when '404' then 
      delicious.delete(url)
      # TODO: Ahm, make sure the above line actually worked!?
      "Deleted #{url}" 
    else "#{response.code}: #{url}"
  end
end
