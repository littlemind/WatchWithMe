class RenameScreeningToReservedAtForReservation < ActiveRecord::Migration
  def self.up
    rename_column :reservations, :screening, :reserved_at
  end

  def self.down
    rename_column :reservations, :reserved_at, :screening
  end
end
