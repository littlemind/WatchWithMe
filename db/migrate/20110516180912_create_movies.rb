class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.references :cinema
      t.date :screening_start
      t.date :screening_end

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
