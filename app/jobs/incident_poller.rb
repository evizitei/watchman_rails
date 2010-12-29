require 'watchman'

class IncidentPoller
  def perform
  end
  
  def new_calls
    Watchman::CallWatcher.new.current_call_incident_numbers.select do |number|
      Incident.find_by_number(number).nil?
    end
  end
  
  def build_incident_from_call_record(call)
    Incident.create!(:address=>call.address,
                     :number=>call.incident_number,
                     :nature=>call.nature,
                     :cross_street_1=>call.cross_streets.first,
                     :cross_street_2=>call.cross_streets.last,
                     :response_level=>call.response_level,
                     :priority=>call.priority)
  end
end