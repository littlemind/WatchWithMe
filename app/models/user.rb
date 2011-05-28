class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :organized_reservations, 
    :class_name => "Reservation", 
    :foreign_key => "organizer_id",
    :order => "reserved_at ASC"
  has_many :participated_reservations, 
    :class_name => "Reservation",
    :through => :tickets, 
    :source => :reservation, 
    :uniq => true, #:select => "DISTINCT reservations.*"
    :order => "reserved_at ASC"
  has_many :tickets, :class_name => "Ticket", 
    :foreign_key => "participant_id"
  
  
  validates_uniqueness_of :username, :case_sensitive => false, :allow_blank => false
  
  def to_param #overridden
    username
  end
  
  def self.find_user_by_url(params_user_id)
    find(:first, :conditions => ["username like ?", params_user_id])    
  end
  
  def reservations
    #Reservation.all(:joins => {:participants => :tickets}, :conditions => {:tickets => {:participant_id => id}},:conditions => {:organizer_id => id})
    return :participated_reservations + :organized_reservations
  end
  
  
end
