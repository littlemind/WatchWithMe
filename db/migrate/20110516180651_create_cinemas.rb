class CreateCinemas < ActiveRecord::Migration
  def self.up
    create_table :cinemas do |t|
      t.string :name
      t.string :location
      t.string :url_adress

      t.timestamps
    end
  end

  def self.down
    drop_table :cinemas
  end
end
