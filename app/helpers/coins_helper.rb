module CoinsHelper
  def sorted_coins
    Coin.joins(:worths)
      .where(worths: { id: Worth.select("max(id) as id").where(quote: 'USD').group([:coin_id]) })
      .ordered_by_market_cap
  end

  def daily_rates(coin)
    daily_quote_ids = Worth.select("max(id) as id")
      .where(coin: coin, quote: 'USD')
      .group([:coin_id, 'quote_time::date'])

    Worth
      .where(id: daily_quote_ids)
      .order('quote_time DESC')
  end

  def chart_line_options
    {
      scales: {
        yAxes: {
          ticks: {
            begin_at_zero: false
          }
        }
      },
      legend: { display: false },
      height: 100
    }
  end

  def aggregated_worths_values_data(coin)
    data = {
      labels: [],
      datasets: [
        {
            background_color: "transparent",
            border_color: "#007bff",
            point_background_color: '#007bff',
            border_width: 4,
            line_tension: 0,
            data: []
        },
      ]
    }

    coin.worths.order('quote_time DESC').limit(100).to_a.reverse.each do |worth|
      label = worth.quote_time.to_date == Date.current ?
        worth.quote_time.strftime("%H:%M") :
        worth.quote_time.strftime("%Y-%m-%d %H:%M")
      data[:labels] << label
      data[:datasets].first[:data] << worth.quoted_value
    end

    data
  end
end
