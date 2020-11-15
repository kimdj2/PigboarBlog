require 'httpclient'

class Imgur

  # imgurアップロードURL
  URL = 'https://api.imgur.com/3/image'

  # クラス初期化 - imgurのClient IDを設定
  def initialize(client_id)
    @client_id = client_id
  end

  # ヘッダーを設定してアップロード
  def anonymous_upload(file)
    auth_header = { 'Authorization' => 'Client-ID ' + @client_id }
    upload(auth_header, file)
  end

  private
  
  # HTTPClientを利用してimgurアップロードに通信
  def upload(auth_header, file)
    @res = HTTPClient.new.post(URI.parse(URL), { 'image' => file }, auth_header)
    result_hash = JSON.load(@res.body)
    result_hash['data']['link']
  end

end
