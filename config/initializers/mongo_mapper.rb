if Rails.env.production?
  if ['MONGOHQ_URL']
    MongoMapper.config = {Rails.env => {'uri' => ENV['MONGOHQ_URL']}}
    MongoMapper.connect(Rails.env)
    Incident.ensure_index(:number)
    Incident.ensure_index(:apparatus)
  end
else
  MongoMapper.config = {Rails.env => {'uri' => "mongodb://localhost/watchman_rails_#{Rails.env}"}}
  MongoMapper.connect(Rails.env)
  Incident.ensure_index(:number)
  Incident.ensure_index(:apparatus)
end
