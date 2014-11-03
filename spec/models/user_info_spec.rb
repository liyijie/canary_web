# == Schema Information
#
# Table name: user_infos
#
#  id          :integer          not null, primary key
#  sex         :integer
#  nickname    :string(255)
#  birth       :date
#  destination :string(255)
#  hotel_type  :integer
#  flight      :string(255)
#  train       :string(255)
#  wechat      :string(255)
#  qq          :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

require 'rails_helper'

RSpec.describe UserInfo, :type => :model do
  describe "attributes" do
    before(:each) do
      @user = create(:user)
      @user.user_info = create(:user_info)
      @user_info = @user.user_info
    end
    it "sex should be a enum attribute" do
      expect(@user_info.sex).to eq "male"
    end

    it "hotel_type should be a enum attribute" do
      expect(@user_info.hotel_type).to eq "start4"
    end

    it "birth should be a date attribute" do
      expect(@user_info.birth).to eq Date.new(2007, 5 ,12)
    end
  end

  describe "user relation" do
    before(:each) do
      @user = create(:user)
      @user.user_info = create(:user_info)
      @user_info = @user.user_info
    end

    it "should have the correct user relation" do
      expect(@user_info.user_id).to eq @user.id
      expect(@user_info.user).to eq @user
    end
  end
end
