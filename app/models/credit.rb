class Credit < ActiveRecord::Base
  belongs_to :friend
  attr_accessible :durum, :friend_id, :miktar, :not, :vade_tarih, :ver_tarih

  #validates :miktar, :presence => true
end
