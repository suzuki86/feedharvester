FactoryGirl.define do
  factory :user_admin, :class => User do
    id 1
    email "example@example.com"
    password_digest "hoge"
  end
end
