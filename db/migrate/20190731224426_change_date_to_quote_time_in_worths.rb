class ChangeDateToQuoteTimeInWorths < ActiveRecord::Migration[5.2]
  def change
    remove_column :worths, :date
    add_column :worths, :quote_time, :datetime, null: false
  end
end
