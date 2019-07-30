class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.date :date, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.integer :market_capitalization, null: false
      t.integer :value_usd_cents, null: false

      t.timestamps
    end

    add_index :currencies, [:date, :code], unique: true
  end
end
