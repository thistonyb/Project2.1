class CreateRocks < ActiveRecord::Migration
  def change
    create_table :rocks do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :location
    end
  end
end
