class CreateThreads < ActiveRecord::Migration[5.0]
  def change
    create_table :threads do |t|
      t.integer :forum_id, :null => false
      t.integer :author_id
      t.integer :lastposter_id
      t.datetime :lastpost_date
      t.integer :edit_by
      t.boolean :closed
      t.string :title
      t.string :slug
      t.text :body
      t.timestamps
    end
  end
end
