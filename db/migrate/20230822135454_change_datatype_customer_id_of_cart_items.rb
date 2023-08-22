class ChangeDatatypeCustomerIdOfCartItems < ActiveRecord::Migration[6.1]
  def change
    change_column :cart_items, :customer_id, :bigint, null: false
  end
end
