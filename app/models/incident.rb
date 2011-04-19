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
  key :map_url,           String
  
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
    @msg ||= "#{address[0,25]}\n#{nature[0,15]}\n#{cropped_apparatus_list[0,12]}\n#{cross_street_1[0,12]}\n#{cross_street_2[0,12]}\n#{build_map_url}"
  end
  
  def cropped_apparatus_list
    app_array = apparatus[0,3]
    app_array << "..." if apparatus.size > 3
    app_array.join("|")
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
  
  def build_map_url
    return map_url if map_url
    local_map_url = self.generate_map_url
    self.map_url = local_map_url
    self.save
    return local_map_url
  end
  
  def self.most_recent
    self.sort(:created_at.desc).first
  end
  
  def self.for_apparatus(apparatus)
    where(:apparatus=>apparatus)
  end

protected
  def generate_map_url
    addy = self.address.to_s
    locality = addy.split("-").last
    city = find_city(locality)
    local_address = addy.gsub("-#{locality}","").gsub("/","&").gsub(/\s+/,"+")
    local_map_url ="http://maps.google.com/maps/api/staticmap" + 
             "?center=#{local_address},+#{city},+MO" + 
             "&zoom=14&size=400x400&sensor=false&markers=color:blue|label:Alarm|"+
             "#{local_address},+#{city},+Mo"
    Googl.shorten(local_map_url).short_url
  end
  
  def find_city(locality)
    case locality
    when "CO"
      "Columbia"
    when "ST"
      "Sturgeon"
    when "CE"
      "Centralia"
    when "BC"
      "BOONE+COUNTY"
    when "HA"
      "HALLSVILLE"
    when "HR"
      "HARRISBURG"
    else
      "Columbia"
    end
  end
end
