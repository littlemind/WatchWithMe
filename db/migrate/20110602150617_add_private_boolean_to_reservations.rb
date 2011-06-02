class AddPrivateBooleanToReservations < ActiveRecord::Migration
  def self.up
    add_column :reservations, :visible_for_public, :boolean, :default => true
  end

  def self.down
    remove_column :reservations, :visible_for_public
  end
end
