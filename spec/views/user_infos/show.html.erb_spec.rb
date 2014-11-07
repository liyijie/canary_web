require 'rails_helper'

RSpec.describe "user_infos/show", :type => :view do
  before(:each) do
    @user_info = assign(:user_info, UserInfo.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
