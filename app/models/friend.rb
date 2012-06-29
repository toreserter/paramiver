class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :credits, :dependent => :destroy
  validates :name, :surname, :email, :presence => true

  attr_accessible :email, :id, :name, :surname, :user_id
end
