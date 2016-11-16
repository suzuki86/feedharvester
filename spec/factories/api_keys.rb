FactoryGirl.define do
  factory :apikey_admin, :class => ApiKey do
    before(:create) do
      ApiKey.skip_callback(:create, :before, :generate_access_token)
    end
    after(:create) do
      ApiKey.set_callback(:create, :before, :generate_access_token)
    end
    user_id 1
    access_token "398e5ff238efe5705dbca92b71a25c00"
  end
end
