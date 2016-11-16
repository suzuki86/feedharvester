FactoryGirl.define do
  factory :dummy_feeds, :class => Feed do
    endpoint_id 1
    url "http://example.com/1234"
    title "TEST TITLE"
    entry_created "2016-01-01 10:00:00"
  end
end
