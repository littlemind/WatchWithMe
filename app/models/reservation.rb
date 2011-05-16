class Reservation < ActiveRecord::Base
  belongs_to :organizer
  belongs_to :movie
  has_many :tickets
  has_many :participants, :class_name => "User", :foreign_key => "participant_id", :through => :tickets
end
