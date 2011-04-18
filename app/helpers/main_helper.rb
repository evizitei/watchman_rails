module MainHelper
  def count_class(count)
    return "stable" if count >= 2
    (count == 0 ? "bad" : "warn")
  end
  
  def message_class(msg)
    return "warn" if msg =~ /City Status Is 1/
    return "bad" if msg =~ /City Status Is 0/
    return "stable"
  end
  
  def generate_map_url(address)
    locality = address.split("-").last
    address = address.gsub("-#{locality}","").gsub(/\s*/,"+")
    map_url ="http://maps.google.com/maps/api/staticmap" + 
             "?center=#{address},+Columbia,+MO" + 
             "&zoom=14&size=400x400&sensor=false&markers=color:blue|label:Alarm|"+
             "#{address},+Columbia,+Mo"
    return map_url
  end
end
