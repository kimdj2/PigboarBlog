FactoryBot.define do
  factory :user do |d|
    d.id 1
    d.username 'testuser'
    d.email 'testuser@test.com'
    d.password "123456"
  end
end
