FactoryBot.define do
  factory :post do
    title { 'Test Title' }
    description { 'Test Description' }

    trait :invalid do
      title { nil }
    end
  end
end
