FactoryBot.define do
  factory :group do
    # Fakerでグループ名を生成（=> "Oregon vixens"）
    name {Faker::Team.name}
  end
end