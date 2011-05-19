class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :organized_reservations, :class_name => "Reservation", :foreign_key => "organizer_id"
  has_many :tickets, :class_name => "Ticket", :foreign_key => "participant_id" 
  has_many :participated_reservations, :class_name => "Reservation",:through => :tickets, :source => :reservation
  
  def to_param
    name
  end
end
