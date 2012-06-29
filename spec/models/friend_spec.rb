require "rspec"
require "spec_helper"


    describe Friend do

      before do
        @friend = FactoryGirl.create(:friend)
      end

      subject {@friend}
      it {should respond_to(:name)}
      it {should respond_to(:surname)}
      it {should respond_to(:email)}

      before do
        @credit = Credit.create(:miktar => 20.0, :friend_id => @friend.id)
      end

      it "should belongs to the credit" do

        @credit.friend_id.should eq(@friend.id)
      end

      it {should be_valid}
      it {should belong_to(:user)}
      it {should have_many(:credits)}
      it "should have a name" do
        @friend.name = ""
        @friend.should_not be_valid
      end
      it "should have a surname" do
        @friend.surname = ""
        @friend.should_not be_valid
      end
      it "should have a email" do
        @friend.email = ""
        @friend.should_not be_valid
      end

    end

