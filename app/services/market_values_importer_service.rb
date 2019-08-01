# This class helps with importing market values data into the system.
# During importing, if `Coin` record is not found for a data, the data
# will not be imported.
class MarketValuesImporterService
  # Returns a list of errors grouped by the coin's slug name
  attr_reader :errors

  def initialize
    @errors = {}
  end

  # Perform the process of importing the market data.
  # Returns true if no errors are found, false otherwise.
  def process
    market_data.each do |data|
      slug = data['slug']
      coin = Coin.find_by_slug(slug)

      if coin.nil?
        add_error(slug, "Unknown coin: #{data['name']}")
        next
      end

      quote_time = DateTime.parse(data['quote']['USD']['last_updated'])

      next if coin.worths.where(quote: 'USD', quote_time: quote_time).any?

      worth = coin.worths.build(
        quote_time: quote_time,
        quote: 'USD',
        market_capitalization: data['quote']['USD']['market_cap'],
        quoted_value: data['quote']['USD']['price']
      )

      worth.save!
    end

    errors.any?
  end

  private

    def market_data
      CoinMarketCap.market_data['data']
    end

    def add_error(slug, message)
      @errors[slug] ||= []
      @errors[slug] << message
    end

end
