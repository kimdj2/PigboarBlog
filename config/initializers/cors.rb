# rack-corsここから
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 許可するドメイン
    origins "localhost", "https://pullog.herokuapp.com"
    # 許可するヘッダとメソッドの種類
    resource "*",
              headers: :any,
              methods: [:get, :post, :patch, :delete, :head, :options]
  end
end
# ここまでrack-cors
