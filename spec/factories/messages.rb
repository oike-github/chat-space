FactoryBot.define do
  factory :message do
    # Fakerでコンテンツを生成（=> "Quia illum libero magni.）
    text {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    user
    group
  end
end