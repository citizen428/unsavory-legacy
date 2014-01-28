require 'httparty'

class PinboardClient
  include HTTParty
  base_uri 'https://api.pinboard.in/v1/'
  headers "User-Agent" => "Unsavory"

  def initialize(opts)
    @options = {:basic_auth => {:username => opts[:user], :password => opts[:pass]}}
    self.class.http_proxy opts[:proxy_host], opts[:proxy_port], opts[:proxy_user], opts[:proxy_pass]
  end

  def get_urls
    response = self.class.get('/posts/all', @options)
    if response.success?
      response['posts']['post'].map { |post| post['href'] }
    end
  end

  def delete(url)
    self.class.get("/posts/delete?url=#{url}", @options)
  end
end
