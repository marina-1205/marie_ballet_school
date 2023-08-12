class CreateLessonClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :lesson_classes do |t|
      
      t.string :name

      t.timestamps
    end
  end
end
