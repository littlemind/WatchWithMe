class AddMeetingAtColumnToReservation < ActiveRecord::Migration
  def self.up
    add_column :reservations, :meeting_at, :datetime
  end

  def self.down
    remove_column :reservations, :meeting_at
  end
end
