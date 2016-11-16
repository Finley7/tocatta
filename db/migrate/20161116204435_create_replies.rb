class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.integer :topic_id, null: false
      t.integer :author_id, null: false
      t.integer :edit_by
      t.text :body, null: false
      t.boolean :deleted, default: false
      t.timestamps
    end
  end
end
