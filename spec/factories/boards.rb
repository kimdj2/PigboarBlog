FactoryBot.define do
  factory :board do |d|
    d.title {'タイトル'}
    d.contents {'テストコンテンツ'}
    d.tag_list {"tag"}
    d.author {'testuser'}
    d.image_path {''}
  end
end
