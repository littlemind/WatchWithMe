class Ticket < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :participant, :class_name => "User"
  
  
  scope :reserved, where("participant_id IS NOT NULL")
  scope :free, where("participant_id IS NULL")
end
