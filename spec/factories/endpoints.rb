FactoryGirl.define do
  factory :dummy_endpoints, :class => Endpoint do
    id 1
    name "TEST ENDPOINT"
    endpoint "http://example.com/rss"
  end
end
