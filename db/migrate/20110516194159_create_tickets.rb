class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.references :reservation
      t.references :participant

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
