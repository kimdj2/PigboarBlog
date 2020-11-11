FactoryBot.define do
  factory :contact do |d|
    d.name {'テスト名前'}
    d.email {'admin@admin.com'}
    d.message {"メッセージテスト"}
  end
end
