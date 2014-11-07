require 'rails_helper'

RSpec.describe "user_infos/edit", :type => :view do
  before(:each) do
    @user_info = assign(:user_info, UserInfo.create!())
  end

  it "renders the edit user_info form" do
    render

    assert_select "form[action=?][method=?]", user_info_path(@user_info), "post" do
    end
  end
end
