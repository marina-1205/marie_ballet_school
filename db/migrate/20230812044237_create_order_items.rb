class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      
      t.references :item, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :make_status, null: false, default: 0

      t.timestamps
    end
  end
end
