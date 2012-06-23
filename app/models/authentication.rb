class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :uid, :token, :token_secret
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
