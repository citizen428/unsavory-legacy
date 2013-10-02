require 'httparty'

class Pinboard
  include HTTParty
  base_uri 'https://api.pinboard.in/v1/'
  headers "User-Agent" => "Unsavory"

  API_METHODS = {
    :all => '/posts/all',
    :delete => '/posts/delete?url='}

  def initialize(user, password)
    @options = {:basic_auth => {:username => user, :password => password}}
  end

  # get_all returns a nested hash, but we want an array of URLs
  def get_all_urls
    get_all['posts']['post'].inject([]) { |urls, post| urls << post['href'] }
  end

  def delete(url)
    self.class.get(API_METHODS[:delete]+url, @options)
  end

  private
  def get_all
    self.class.get(API_METHODS[:all], @options)
  end
end


