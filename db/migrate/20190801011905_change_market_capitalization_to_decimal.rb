class ChangeMarketCapitalizationToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :worths, :market_capitalization, :decimal
  end
end
