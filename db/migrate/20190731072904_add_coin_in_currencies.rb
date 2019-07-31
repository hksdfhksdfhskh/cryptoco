class AddCoinInCurrencies < ActiveRecord::Migration[5.2]
  def change
    add_column :currencies, :coin_id, :integer, null: false
    add_index :currencies, :coin_id

    remove_column :currencies, :code
    remove_column :currencies, :name
  end
end
