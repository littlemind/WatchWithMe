class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.references :organizer
      t.references :movie
      t.decimal :ticket_prize
      t.datetime :screening
      t.integer :cinema_room

      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
