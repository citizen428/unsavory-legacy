require 'httparty'

class PinboardClient
  include HTTParty
  base_uri 'https://api.pinboard.in/v1/'
  headers "User-Agent" => "Unsavory"

  def initialize(user, password)
    @options = {:basic_auth => {:username => user, :password => password}}
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
