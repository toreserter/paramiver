require "spec_helper"
include Devise::TestHelpers

describe FriendsController do

  def mock_credit(stubs={})
    @mock_credit ||= mock_model(Credit, stubs).as_null_object
  end

  def mock_friend(stubs={})
    @mock_friend ||= mock_model(Friend, stubs).as_null_object
  end


  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @friend = FactoryGirl.create(:friend, user_id: @user.id)
    @credit = FactoryGirl.create(:credit, friend_id: @friend.id)
    sign_in :user, @user
  end
  describe "GET index" do
    it "should not show other user's friends" do
      Friend.stub(:find).with("1") {mock_friend}
      get :index
      assigns(:friends).should_not eq(mock_friend)
    end
    it "should show user's friends" do
      get :index
      assigns(:friends).should eq([@friend])
    end
  end
  describe "GET friends show" do
    it "should find all credits belongs to given friend id" do
      get :show, :id => "1"
      assigns(:friend).should eq(@friend)
    end
  end
  describe "GET new friend" do
    it "should render new form" do
      get :new
      response.should be_success
      response.should render_template("new")
    end
    it "should create a new friend" do
      Friend.stub(:new).with("asdas" => "asd") {mock_friend}
      post :create, :friend => {"asdas" => "asd"}
      assigns(:friend).should be(mock_friend)
    end
    it "should render new form if unsuccessful save" do
      Friend.stub(:new).with("these" => "params") {mock_friend(:save => false)}
      post :create, :friend =>  {"these" => "params"}
      response.should be_success
      response.should render_template("new")
    end
  end
  describe "GET edit friend" do
    before(:each) do
      Friend.stub(:find).with("1") {mock_friend}
    end
    it "should receive update attributes" do
      mock_friend.should_receive(:update_attributes).with("these" => "params")
      put :update, :id => "1", :friend => {"these" => "params"}
    end
    it "should redirect to friends path" do
      put :update, :id => "1", :friend => {"these" => "params"}
      assigns(:friend).should redirect_to(mock_friend)
    end
    it "should render template if error occurs" do
      Friend.stub(:find).with("1") { mock_friend(:update_attributes => false) }
      mock_friend.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => "1", :friend => {"these" => "params"}
      assigns(:friend).should render_template(:edit)
    end
  end
  describe "DELETE destroy" do
    it "should delete friend" do
      Friend.stub(:find).with("1") {mock_friend}
      mock_friend.should_recieve(:destroy)
      delete :destroy, :id => "1"
    end
    it "should redirect to friends url" do
      Friend.stub(:find) {mock_friend}
      delete :destroy, :id =>"1"
      response.should redirect_to(friends_url)
    end
  end
end