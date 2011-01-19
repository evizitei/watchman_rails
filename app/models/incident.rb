class Incident
  include MongoMapper::Document
  
  key :address,           String
  key :number,            String
  key :nature,            String
  key :cross_street_1,    String
  key :cross_street_2,    String
  key :response_level,    String
  key :priority,          Fixnum
  key :dispatch_code,     String
  key :grid,              String
  key :tac_channel,       String  
  key :fire_area,         String    
  key :cautions,          String
  key :alarm_struck_at,   DateTime
  key :first_on_scene_at, DateTime
  key :upgrade_at,        DateTime
  key :patient_contact_at,DateTime
  key :notes,             String
  key :created_at,        DateTime
  key :apparatus,         Array
  
  def initialize(attrs={})
    super({:created_at=>DateTime.now}.merge(attrs))
  end
  
  def dispatch_notifications!
    if interesting?
      #time = Time.now + 2.hours
      User.all.each do |user|
        if user.is_subscribed_to?(apparatus)
          user.send_sms!(formatted_message)
        end
      end
      true
    end
  end
  
  def formatted_message
    @msg ||= "#{address}\n#{nature}\n#{apparatus.join("|")}\n#{cross_street_1}\n#{cross_street_2}"
  end
  
  def interesting?
    return false if number =~ /^[wW]/
    
    if apparatus.size > 1
      true
    elsif apparatus.size == 1
      rig = apparatus.first
      !(rig =~ /M\d{3}/ || rig =~ /EMSAC/)
    else
      false
    end
  end
  
  def self.most_recent
    self.sort(:created_at.desc).first
  end
  
  def self.for_apparatus(apparatus)
    where(:apparatus=>apparatus)
  end
end
