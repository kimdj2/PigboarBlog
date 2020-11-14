# rack-corsここから
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 許可するドメイン
    origins "localhost", "https://pullog.herokuapp.com", "https://www.pullog.tokyo"
    # 許可するヘッダとメソッドの種類
    resource "*",
              headers: :any,
              methods: [:get, :post, :patch, :delete, :head, :options],
              credentials: true

  end
end
# ここまでrack-cors
