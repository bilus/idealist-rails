class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.string :title
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end
