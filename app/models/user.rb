class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :phone, :organization_id, :subscriptions, :day_subscriptions,
                  :is_sms_subscriber, :is_email_subscriber
  
  validates_presence_of :phone,:organization_id
  validates_format_of :phone,:with=>/^\d{11}$/
  
  before_create :check_organization_id
  
  serialize :subscriptions,Array
  
  def initialize(attrs = {})
    super(attrs)
    self.subscriptions ||= []
    self.day_subscriptions ||= []
  end
  
  def phone=(value)
    if value
      value = value.gsub(/\s+|\-|\(|\)/,"")
      value = "1#{value}" if value.size == 10
    end
    
    self[:phone] = value
  end
  
  def add_subscription!(truck)
    self.subscriptions = (self.subscriptions + [truck]).uniq
    self.save!
  end
  
  def add_day_subscription!(truck)
    self.day_subscriptions = (self.day_subscriptions + [truck]).uniq
    self.save!
  end
  
  def remove_subscription!(truck)
    self.subscriptions = (self.subscriptions - [truck]).uniq
    self.save!
  end
  
  def send_sms!(message)
    TWILIO.send_sms!(message, phone)
  end
  
  def send_email!(message)
    InternalMailer.generic_message(self,message).deliver
  end
  
  def is_subscribed_to?(apparatus_list)
    subs = subscriptions
    subs += day_subscriptions if is_daytime?
    (subs.uniq & apparatus_list).size > 0
  end
  
protected
  
  def check_organization_id
    if OrganizationId.find_by_name(organization_id).nil?
      errors[:base] << "you must have an active organization id"
      false
    else
      true
    end
  end
  
  def is_daytime?
    Time.now.hour >= 8 and Time.now.hour <= 21
  end
end
