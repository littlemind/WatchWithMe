class Ticket < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :participant
end
