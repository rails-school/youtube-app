class HomeController < ApplicationController
  def index
    result = {"access_token"=>
                "ya29.1.AADtN_VWlnbTqLwT7mF401QWLn4mLZJ6zrW-nPPLhuruK2zRATJCFLgrDOp4k5PnD7h5eA",
              "token_type"=>"Bearer",
              "expires_in"=>3600,
              "refresh_token"=>"1/eqKR0KiNdaz0MqDZEzlRmyApF9uVz205jQYcoRpLtwA"}


    client = YouTubeIt::OAuth2Client.new(client_access_token: result['access_token'], client_refresh_token: result['refresh_token'], client_id: CLIENT_ID, client_secret: CLIENT_SECRET, dev_key: DEV_KEY, expires_at: result['expires_in'])
    begin
      @videos = client.my_videos
    rescue
      client.refresh_access_token!
      @videos = client.my_videos
    end
  end
end
