class Reservation < ActiveRecord::Base
  belongs_to :organizer, :class_name => "User"
  belongs_to :movie
  has_many :tickets
  has_many :participants, :class_name => "User", :source => :participant, :through => :tickets
  
  accepts_nested_attributes_for :tickets, :allow_destroy => true
  
end
