class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :image_id
      t.integer :genre_id, null: false
      t.boolean :is_available, default: true, null: false

      t.timestamps
    end
  end
end
