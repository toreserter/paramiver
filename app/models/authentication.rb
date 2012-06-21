class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :uid
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = omniauth["provider"]
      user.uid = omniauth["uid"]
      user.name = omniauth["info"]["name"]
    end
  end
end
