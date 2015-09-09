class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.attachment :image

      t.timestamps null: false
      add_attachment :posts, :image  
    end
  end
end
