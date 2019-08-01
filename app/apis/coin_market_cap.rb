# API library for CoinMarketCap
# dashboard: https://pro.coinmarketcap.com/login
module CoinMarketCap
  HOST = "https://pro-api.coinmarketcap.com"
  API_KEY = SECRETS[:coin_market_cap_api_key]
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
    parse(response)
  end

  def parse(response)
    body = JSON.parse(response.body)
    status = body['status']
    error_code, error_message = status['error_code'], status['error_message']

    raise Error.new("Experienced error with code #{error_code}: #{error_message}") unless error_code.zero?

    body
  end

  # list_coins returns a current list of all active currencies supported
  def list_coins
    endpoint = "#{HOST}/v1/cryptocurrency/map"
    get(endpoint)
  end

  def market_data
    endpoint = "#{HOST}/v1/cryptocurrency/listings/latest"
    get(endpoint)
  end
end
