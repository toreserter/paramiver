class User < ActiveRecord::Base
  has_many :authentications
  has_many :credits
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :token
  # attr_accessible :title, :body
  def apply_oauth(auth)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
