require "rspec"
require "spec_helper"

describe Credit do

  before do
    @credit = FactoryGirl.create(:credit)
  end

  subject {@credit}
  it {should respond_to(:miktar)}
  it {should respond_to(:durum)}
  it {should respond_to(:not)}


  it {should be_valid}
  it {should belong_to(:friend)}

  it "should have a miktar" do
    subject.miktar = ""
    subject.should_not be_valid
  end

end