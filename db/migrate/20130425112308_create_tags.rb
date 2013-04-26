class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, uniqueness: true
    end
  end
end
  