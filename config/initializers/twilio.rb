require 'twiliolib'
require 'twilio_wrapper'

TWILIO_API_VERSION = '2010-04-01'
TWILIO_ACCOUNT_SID = 'ACc081fe7fde0e49c976a0bd1cda993825'
TWILIO_ACCOUNT_TOKEN = '3eaa74cf4eb1857a2f11fe19a834b174'
TWILIO_CALLER_ID = '5735355323'

params = {:from=>TWILIO_CALLER_ID,
          :version=>TWILIO_API_VERSION,
          :sid=>TWILIO_ACCOUNT_SID}
          
client = Twilio::RestAccount.new(TWILIO_ACCOUNT_SID, TWILIO_ACCOUNT_TOKEN)
TWILIO = TwilioWrapper.new(client,params)