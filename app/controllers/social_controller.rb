class SocialController < ApplicationController
  def create
    if params[:tore] == "twitter"
      #twitter üzerinde borçlu olanı ifşa ediyoruz ...
      twitter = current_user.authentications.find_by_provider("twitter")
      if twitter.present?
        Twitter.configure do |config|
          config.consumer_key = "zui8uknb7XCUemfMIdjuiw"
          config.consumer_secret = "gQOYnWbBql9w88ztDHYw7RxZowdgDUnZ27mtaNkgXz8"
          config.oauth_token = twitter.token
          config.oauth_token_secret = twitter.token_secret
        end
        Twitter.update(params[:tweet])
      end
    end
    if params[:tore] == "facebook"
      #facebook üzerinde borçlu olanı ifşa ediyoruz ...
      facebook = current_user.authentications.find_by_provider("facebook")
      if facebook.present?
        me = FbGraph::User.me(facebook.token)
        me.feed!(
            :message => "#{params[:face]}",
            :link => 'http://paramiver.herokuapp.com',
            :name => 'Parami Ver :)',
        )
      end
      redirect_to credits_path()
    end
  end

end
