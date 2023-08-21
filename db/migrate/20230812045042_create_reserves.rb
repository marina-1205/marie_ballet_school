class CreateReserves < ActiveRecord::Migration[6.1]
  def change
    create_table :reserves do |t|
      
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_kana_name, null: false
      t.string :first_kana_name, null: false
      t.integer :age, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.integer :reservation_date, null: false
      t.integer :lesson_class_id, null: false
      t.boolean :reservation_status, default: true, null: false

      t.timestamps
    end
  end
end
