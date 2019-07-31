class ChangeCurrenciesToWorths < ActiveRecord::Migration[5.2]
  def change
    rename_table :currencies, :worths
  end
end
