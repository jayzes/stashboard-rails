class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime  :started_at
      t.boolean   :is_informational, :default => false
      t.integer   :status_id
      t.text      :message
      t.integer   :service_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
