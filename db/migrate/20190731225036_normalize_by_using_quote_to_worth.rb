class NormalizeByUsingQuoteToWorth < ActiveRecord::Migration[5.2]
  def change
    remove_column :worths, :value_usd_cents
    add_column :worths, :quote, :string, null: false
    add_column :worths, :quoted_value, :decimal, null: false
  end
end
