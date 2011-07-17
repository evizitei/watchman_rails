class TwilioWrapper

  def initialize(client,params)
    @params = params
    @client = client
  end
  
  def send_sms!(message,number)
    t = {
        'From' => @params[:from],
        'To'   => number,
        'Body' => message
    }
    resp = @client.request("/#{@params[:version]}/Accounts/#{@params[:sid]}/SMS/Messages",
          "POST", t)
  end
end