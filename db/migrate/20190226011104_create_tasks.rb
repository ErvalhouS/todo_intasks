class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :due_at
      t.datetime :completed_at
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
