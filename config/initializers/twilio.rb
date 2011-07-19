require 'twiliolib'
require 'twilio_wrapper'

TWILIO_API_VERSION = '2010-04-01'
TWILIO_ACCOUNT_SID = 'ACd54a933dbab136f01fd7b432a52d7f22'
TWILIO_ACCOUNT_TOKEN = '894b51d5a553fc0723e6b6e64c4617a7'
TWILIO_CALLER_ID = '4155992671'

params = {:from=>TWILIO_CALLER_ID,
          :version=>TWILIO_API_VERSION,
          :sid=>TWILIO_ACCOUNT_SID}
          
client = Twilio::RestAccount.new(TWILIO_ACCOUNT_SID, TWILIO_ACCOUNT_TOKEN)
TWILIO = TwilioWrapper.new(client,params)