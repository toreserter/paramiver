FactoryGirl.define do
  factory :user do
    email "a@a.com"
    password "fakfak"
    password_confirmation  "fakfak"
  end

  factory :friend do
    id 1
    name "ali"
    surname "veli"
    email "a@a.com"
    user_id 1

  end

  factory :credit do
    id 1
    #miktar 1.30
    durum ""
    friend_id 1
  end

  factory :authentication do
    user_id 1
    provider "twitter"
  end

end