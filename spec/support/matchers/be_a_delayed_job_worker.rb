RSpec::Matchers.define :be_a_delayed_job_worker do 
  match do |actual|
    actual.should respond_to(:perform)
  end
end