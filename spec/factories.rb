FactoryBot.define do
  factory :coin do
    slug 'bitcoin'
    symbol 'BTC'
    name 'Bitcoin'
  end

  factory :worth do
    date { Date.parse("2019-08-17") }
    coin { create(:coin) }
    market_capitalization { 1_000_000 }
    value_usd_cents { 500 }
  end
end
