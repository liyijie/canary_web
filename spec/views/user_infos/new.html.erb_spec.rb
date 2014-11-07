require 'rails_helper'

RSpec.describe "user_infos/new", :type => :view do
  before(:each) do
    assign(:user_info, UserInfo.new())
  end

  it "renders new user_info form" do
    render

    assert_select "form[action=?][method=?]", user_infos_path, "post" do
    end
  end
end
