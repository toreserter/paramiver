#require "rspec"
require "spec_helper"
describe "User" do
  before do
    @user = FactoryGirl.create(:user)
  end
  subject {@user}
  it {should have_many(:friends)}
  it {should have_many(:authentications)}
  it {should respond_to(:email)}
  it {should respond_to(:password)}




end