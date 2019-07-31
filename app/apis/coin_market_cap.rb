# API library for CoinMarketCap
# dashboard: https://pro.coinmarketcap.com/login
module CoinMarketCap
  HOST = "https://pro-api.coinmarketcap.com"
  API_KEY = Rails.application.credentials.config[Rails.env.to_sym][:coin_market_cap_api_key]
  TIMEOUT = 5.seconds

  extend self

  def get(endpoint)
    response = Typhoeus::Request.new(
      endpoint,
      method: :get,
      headers: {
        'Accepts' => 'application/json',
        'X-CMC_PRO_API_KEY' => API_KEY  
      },
      timeout: TIMEOUT
    ).run

    raise TimeoutError.new("Timeout on: #{endpoint}") if response.timed_out?

    JSON.parse(response.body)
  end

  # list_currencies returns a current list of all active currencies supported
  # by CoinMarketCap
  def list_currencies
    endpoint = "#{HOST}/v1/cryptocurrency/map"
    get(endpoint)
  end
end