namespace :market_values do
  desc "Fetch market values of coins"
  task update: :environment do
    CurrenciesListImporterService.new.process
    MarketValuesImporterService.new.process
  end
end
