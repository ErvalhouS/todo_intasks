class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :tasks_count, default: 0
      t.references :user, foreign_key: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
