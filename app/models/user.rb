class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :has_local_pw
  
  has_many :organized_reservations, 
    :class_name => "Reservation", 
    :foreign_key => "organizer_id",
    :order => "reserved_at ASC",
    :dependent => :destroy
  has_many :participated_reservations, 
    :class_name => "Reservation",
    :through => :tickets, 
    :source => :reservation, 
    :uniq => true, #:select => "DISTINCT reservations.*"
    :order => "reserved_at ASC"
  has_many :tickets, :class_name => "Ticket", 
    :foreign_key => "participant_id"
  has_many :authentications,
    :dependent => :destroy
  
  
  validates_uniqueness_of :username, :case_sensitive => false, :allow_blank => false
  validates_presence_of :username, :message => "can't be blank"
  
  def to_param #overridden
    username
  end
  
  def self.find_user_by_url(params_user_id)
    find(:first, :conditions => ["username like ?", params_user_id])    
  end
  
  def reservations
    #Reservation.all(:joins => {:participants => :tickets}, :conditions => {:tickets => {:participant_id => id}},:conditions => {:organizer_id => id})
    return participated_reservations
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else
      if User.find_by_username(data["username"])# Create a user with a stub password. 
        User.create!(:email => data["email"], :password => Devise.friendly_token[0,20], :username => data["username"] << data["id"], :has_local_pw => :false)
      else
        User.create!(:email => data["email"], :password => Devise.friendly_token[0,20], :username => data["username"], :has_local_pw => :false)
      end
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
  
  def created_through_facebook?
    if authentication = self.authentications.find_by_provider("facebook")
      self.created_at < authentication.created_at
    else
      false
    end
  end
  
  
end
