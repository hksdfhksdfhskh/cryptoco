class CreateCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :coins do |t|
      t.string :slug, null: false
      t.string :symbol, null: false
      t.string :name, null: false
      t.boolean :is_active, null: false, default: true
      t.integer :platform_id

      t.timestamps
    end

    add_index :coins, :slug, unique: true
  end
end
