require 'rails_helper'

RSpec.describe "user_infos/index", :type => :view do
  before(:each) do
    assign(:user_infos, [
      UserInfo.create!(),
      UserInfo.create!()
    ])
  end

  it "renders a list of user_infos" do
    render
  end
end
