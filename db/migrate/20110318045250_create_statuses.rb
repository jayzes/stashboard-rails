class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :image
      t.integer :severity

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
