require "rspec"

require "spec_helper"
describe Authentication do
  before do
     @authentication = Authentication.new(:provider => "twitter", :uid => "17")
  end
  subject {@authentication}

  it { should respond_to(:uid)}
  it { should respond_to(:provider)}
  it { should be_valid}



end