require 'twiliolib'
require 'twilio_wrapper'

TWILIO_API_VERSION = '2010-04-01'
TWILIO_ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
TWILIO_ACCOUNT_TOKEN = ENV['TWILIO_ACCOUNT_TOKEN']
TWILIO_CALLER_ID = ENV['TWILIO_CALLER_ID']

params = {:from=>TWILIO_CALLER_ID,
          :version=>TWILIO_API_VERSION,
          :sid=>TWILIO_ACCOUNT_SID}

client = Twilio::RestAccount.new(TWILIO_ACCOUNT_SID, TWILIO_ACCOUNT_TOKEN)
TWILIO = TwilioWrapper.new(client,params)
