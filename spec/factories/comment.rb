FactoryBot.define do
  factory :comment do
    body { 'MyText' }
    association :post, factory: :post
    association :user, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end