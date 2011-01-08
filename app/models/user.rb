class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone
  
  validates_presence_of :phone
  validates_format_of :phone,:with=>/^\d{11}$/
  
  def phone=(value)
    self[:phone] = value.nil? ? nil : value.gsub(/\s+|\-|\(|\)/,"")
  end
end
