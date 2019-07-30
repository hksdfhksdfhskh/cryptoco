FactoryBot.define do
  factory :currency do
    date { Date.parse("2019-08-17") }
    code { 'btc' }
    name { 'Bitcoin' }
    market_capitalization { 1_000_000 }
    value_usd_cents { 500 }
  end
end
