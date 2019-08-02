FactoryBot.define do
  factory :coin do
    slug 'bitcoin'
    symbol 'BTC'
    name 'Bitcoin'
  end

  factory :worth do
    quote_time { Date.parse("2019-08-17") }
    coin { create(:coin) }
    market_capitalization { 1_000_000 }
    quote 'USD'
    quoted_value { 500 }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
  end
end
