require 'httpclient'

# imgur upload simple module
class Imgur

  URL = 'https://api.imgur.com/3/image'

  def initialize(client_id)
    @client_id = client_id
  end

  def anonymous_upload(file)
    auth_header = { 'Authorization' => 'Client-ID ' + @client_id }
    upload(auth_header, file)
  end

  private

  def upload(auth_header, file)
    http_client = HTTPClient.new
    @res = http_client.post(URI.parse(URL), { 'image' => file }, auth_header)
    puts 'aaa'
    puts @res.inspect
    result_hash = JSON.load(@res.body)
    result_hash['data']['link']
  end

end
