module CoinsHelper
  def sorted_coins
    Coin.joins(:worths)
      .where(worths: { id: Worth.select("max(id) as id").where(quote: 'USD').group([:coin_id]) })
      .order("worths.market_capitalization DESC")
  end
end
