class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :phone, :organization_id, :subscriptions
  
  validates_presence_of :phone,:organization_id
  validates_format_of :phone,:with=>/^\d{11}$/
  
  before_create :check_organization_id
  
  serialize :subscriptions,Array
  
  def initialize(attrs = {})
    super(attrs)
    self.subscriptions ||= []
  end
  
  def phone=(value)
    self[:phone] = value.nil? ? nil : value.gsub(/\s+|\-|\(|\)/,"")
  end
  
  def add_subscription!(truck)
    self.subscriptions = (self.subscriptions + [truck]).uniq
    self.save!
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
end
