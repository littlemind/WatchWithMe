class Reservation < ActiveRecord::Base
  belongs_to :organizer, :class_name => "User"
  belongs_to :movie
  has_many :tickets,
    :order => "participant_id DESC"#,
#    :dependent => :destroy
  has_many :participants, :class_name => "User", :source => :participant, :through => :tickets
  
  delegate :title, :to => :movie
  
  accepts_nested_attributes_for :tickets, :allow_destroy => true
  
  validates_presence_of :reserved_at, :on => :create, :message => "can't be blank, must take place some time"
  validates_presence_of :movie, :on => :create, :message => "can't be blank"
  
  named_scope :upcoming, :conditions => ["reserved_at > ?", Time.now ]
  named_scope :recent, lambda { |time_ago| { :conditions => ['reserved_at > ?', time_ago] } }
  
  
end
