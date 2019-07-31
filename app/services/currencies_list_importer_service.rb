# CurrenciesListImporterService will import list of currencies. When a currency record is already found,
# the service class will do nothing. Otherwise, a record for that currency will be created.
# Hence, this service class is callable at anytime.
class CurrenciesListImporterService
  def process
    listed_coins.each do |coin_data|
      Coin.transaction do
        coin = create_or_update_coin(coin_data)
        update_platform_association(coin, coin_data)  
      end
    end
  end

  private

    def listed_coins
      @listed_coins ||= CoinMarketCap.list_coins['data']
    end

    def known_coins
      @known_coins ||= Coin.order('slug ASC').to_a
    end

    def missing_currencies
      @missing_currencies ||= begin
        slugs ||= listed_coins.map { |c| c['slug'] }
        slugs - known_coins.map(&:slug)
      end
    end

    def create_or_update_coin(coin_data)
      if missing_currencies.include? coin_data['slug']
        coin = Coin.new(slug: coin_data['slug'])
      else
        coin = known_coins.bsearch { |x| coin_data['slug'] <=> x.slug }
      end

      coin.symbol = coin_data['symbol']
      coin.name = coin_data['name']
      coin.is_active = coin_data['is_active'] == 1
      coin.save!

      coin
    end

    def update_platform_association(coin, coin_data)
      platform = coin_data['platform']

      return if platform.blank? && coin.platform.nil?

      coin.platform = platform.nil? && coin.platform.present? ?
        nil :
        Coin.find_by_slug(platform['slug'])

      coin.save!
    end

end
