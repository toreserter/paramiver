class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :credits

  attr_accessible :email, :id, :name, :surname, :user_id
end
