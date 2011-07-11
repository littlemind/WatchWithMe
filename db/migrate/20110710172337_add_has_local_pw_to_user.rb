class AddHasLocalPwToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :has_local_pw, :boolean, :default => true
  end

  def self.down
    remove_column :users, :has_local_pw
  end
end
