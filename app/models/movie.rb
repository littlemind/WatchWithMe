class Movie < ActiveRecord::Base
  belongs_to :cinema
  has_many :reservations
end
