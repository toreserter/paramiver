require "spec_helper"

include Devise::TestHelpers

describe CreditsController do

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
    it "should get credit list" do
      credit = stub_model(Credit)
      Credit.stub(:all) { credit }

      get :index
      assigns(:credits).should include(@credit)
    end
  end
  describe "GET new" do
    it "should create a new credit" do
      Credit.should_receive(:new)
      get :new
      response.should render_template("new")
    end
  end
  describe "POST create with valid params" do                                                                             #hata var

      it "should create new credit and redirect to credits url" do
        Credit.stub(:new) { @credit }
        Friend.stub(:find).with(@credit.friend_id) {@friend}
        @friend.should_receive(:create).and_return(true)
        @credit.should_receive(:save).and_return(true)
        post :create
        response.should redirect_to(credit_path(@credit))
      end
  end
  describe "GET credit show" do
    it "should find the all credits belongs to given id" do
      Credit.stub!(:find).with("1") {mock_credit}
      get :show, :id => "1"
      assigns(:credit).should eq(mock_credit)
    end
  end
  describe "GET credit edit page" do
    it "should edit credit" do
      Credit.stub(:find).with("1") {mock_credit}
      get :edit, :id => "1"
      response.should be_success
      response.should render_template('edit')
    end
  end
  describe "PUT update" do
    before(:each) do
      Credit.stub(:new).with({"these" => "params"}) {mock_credit(:save => true, :friend_id => @friend.id)}
      post :create, :credit => {"these" => "params"}
      Credit.stub(:find).with("1") {mock_credit(:update_attributes => true)}

    end
    it "updates the requested credit" do
      mock_credit.should_receive(:update_attributes).with({"these" => "params"})
      put :update, :id => "1", :credit => {"these" => "params"}
    end
    it "should redirect to the credit path(show) after successful update" do                                             #hata var
      put :update, :id => "1", :credit => {"these" => "params"}
      assigns(:credit).should redirect_to(credit_path(@credit))
    end
    it "should render template" do
      Credit.stub(:find).with("1") {mock_credit(:update_attributes => false)}
      mock_credit.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => "1", :credit => {"these" => "params"}
      assigns(:credit).should render_template(:edit)
    end
  end

  describe "GET new credit" do
    it "should render new form" do
      get :new
      response.should be_success
      response.should render_template('new')
    end
    it "should create a new credit which belongs to user's friend with given params" do
      Credit.stub(:new).with({"these" => "params"}) {mock_credit(:save => true, :friend_id => @friend.id)}
      post :create, :credit => {"these" => "params"}
      assigns(:credit).should eq(mock_credit)
    end

  end
  describe "DELETE destroy" do
    before(:each) do
      Credit.stub(:new).with({"these" => "params"}) {mock_credit(:save => true, :friend_id => @friend.id)}
      post :create, :credit => {"these" => "params"}

    end
    it "should destroy the credit" do
      Credit.stub(:find).with("1") {mock_credit}
      mock_credit.should_receive(:destroy)
      delete :destroy, :id => "1"
    end
    it "should redirect to the credits path" do
      Credit.stub(:find) {mock_credit}
      delete :destroy, :id => "1"
      response.should redirect_to(credits_url)
    end
  end
end