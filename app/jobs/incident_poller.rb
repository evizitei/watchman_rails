require 'watchman'

class IncidentPoller
  def perform
    begin
      WatchmanStatus.active!
      new_calls.each do |number|
        incident = build_incident_from_call_record(watcher.info_for(number))
        incident.dispatch_notifications!
      end
      Delayed::Job.enqueue(IncidentPoller.new, 0, 20.seconds.from_now)
    rescue => e
      WatchmanStatus.kill!
      begin
        InternalMailer.polling_error(e.message).deliver
      rescue => e
      end
      Delayed::Job.enqueue(IncidentPoller.new, 0, 2.minutes.from_now)
    end
  end
  
  def new_calls
    watcher.current_call_incident_numbers.select do |number|
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
                     :priority=>call.priority,
                     :apparatus=>call.apparatus,
                     :notes=>call.notes,
                     :split_notes=>call.spliced_notes)
  end
  
private
  def watcher
    @watcher ||= Watchman::CallWatcher.new
  end
end