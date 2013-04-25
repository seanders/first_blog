class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.string :content, :null => false
      t.references :user, :null => false
      t.timestamps
    end
  end
end
