class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false, :uniqueness => true
      t.string :password_hash, :null => false
      t.string :token
      t.string :username, :null => false, :uniqueness => true
      t.timestamps
    end
  end
end