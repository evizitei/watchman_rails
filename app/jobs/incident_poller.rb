require 'watchman'
require 'delayed_job'

class IncidentPoller
  def perform
    begin
      WatchmanStatus.active!
      current_calls.each do |number|
        watcher_call = watcher.info_for(number)
        incident = Incident.find_by_number(number)
        if incident.nil?
          incident = build_incident_from_call_record(watcher_call)
          incident.dispatch_notifications!
        else
          update_incident(incident, watcher_call)
        end
      end
      Delayed::Job.enqueue(IncidentPoller.new, priority: 0, run_at: 20.seconds.from_now)
    rescue => e
      WatchmanStatus.kill!
      begin
        InternalMailer.polling_error(e.message).deliver
      rescue => e
      end
      Delayed::Job.enqueue(IncidentPoller.new, priority: 0, run_at: 2.minutes.from_now)
    end
  end

  def current_calls
    watcher.current_call_incident_numbers
  end

  def update_incident(incident, call)
    incident.notes = call.notes
    incident.split_notes = call.spliced_notes
    incident.save
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
                     :notes=>call.raw_notes,
                     :split_notes=>call.spliced_notes)
  end

private
  def watcher
    @watcher ||= Watchman::CallWatcher.new
  end
end
