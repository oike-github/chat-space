FactoryBot.define do
  factory :user do
    # Fakerで8桁以上のパスワードを生成（=> "YfGjIk0hGzDqS0"）
    password = Faker::Internet.password(min_length: 8)
    # Fakerで名前を生成（=> "Ernser"）
    name {Faker::Name.last_name}
    # Fakerでメールアドレスを生成（=> "freddy@gmail.com"）
    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
  end
end