# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory(:user) do
    email { 'jane.doe@hey.com' }
    password { 'SecretPassword123' }
  end
end
