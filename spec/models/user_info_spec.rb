# == Schema Information
#
# Table name: user_infos
#
#  id                  :integer          not null, primary key
#  sex                 :integer
#  nickname            :string(255)
#  birth               :date
#  destination         :string(255)
#  hotel_type          :integer
#  flight              :string(255)
#  train               :string(255)
#  wechat              :string(255)
#  qq                  :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  user_id             :integer
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe UserInfo, :type => :model do
  describe "attributes" do
    before(:each) do
      @user = create(:user)
      @user.user_info = create(:user_info)
      @user_info = @user.user_info
      Sunspot.commit
    end
    it "sex should be a enum attribute" do
      expect(@user_info.sex).to eq "male"
    end

    it "hotel_type should be a integer attribute" do
      expect(@user_info.hotel_type).to eq 2
    end

    it "birth should be a date attribute" do
      expect(@user_info.birth).to eq Date.new(2007, 5 ,12)
    end

    it "should be count constellation right" do
      expect(@user_info.constellation).to eq "金牛座"
    end

  end

  describe "user relation" do
    before(:each) do
      @user = create(:user)
      @user.user_info = create(:user_info)
      @user_info = @user.user_info
      Sunspot.commit
    end

    it "should have the correct user relation" do
      expect(@user_info.user_id).to eq @user.id
      expect(@user_info.user).to eq @user
    end
  end

  context 'searchable' do

    describe "sunspot_rails" do
      before(:each) do
        5.times { create(:male_user_info) }
        6.times { create(:female_user_info) }
        Sunspot.commit
      end

      it "should find male user infos" do
        users = UserInfo.search do
          with :sex, "male"
        end
        expect(users.results.count).to eq 5
      end

      it "should find female user infos" do
        users = UserInfo.search do
          with :sex, "female"
        end
        expect(users.results.count).to eq 6
      end

      it "should find by destination with part of string" do
        users = UserInfo.search do
          fulltext "北京"
        end
        expect(users.results.count).to eq 11
      end

      it "should find by destination with excact string" do
        users = UserInfo.search do
          fulltext "北京天安门"
        end
        expect(users.results.count).to eq 6
      end

      it "should find by hotel_type" do
        users = UserInfo.search do
          with(:hotel_type).greater_than 1
        end
        expect(users.results.count).to eq 11
        users = UserInfo.search do
          with(:hotel_type).greater_than_or_equal_to 2
        end
        expect(users.results.count).to eq 11
        users = UserInfo.search do
          with(:hotel_type).greater_than_or_equal_to 3
        end
        expect(users.results.count).to eq 5
      end
    end

    describe "pagenate+sunspot_rails" do
      before(:each) do
        5.times { create(:male_user_info) }
        6.times { create(:female_user_info) }
        Sunspot.commit
      end
      users = UserInfo.search do
        with :sex, "male"
        paginate per_page: 2
      end
      it "should be paginate correct" do
        expect(users.results.total_pages).to eq 3
        expect(users.results).to be_first_page 
        expect(users.results.current_page).to eq 1
      end
    end
  end

  context 'match user infos' do
    before(:each) do
      5.times { create(:male_user_info, destination: "北京") }
      6.times { create(:female_user_info, destination: "天安门") }
      7.times { create(:female_user_info, destination: "北京") }
      Sunspot.commit
    end
    describe "male condition" do
      it "should not find parts female user infos" do
        @male = create(:male_user_info, destination: "北京市")
        match_users = @male.find_match_user_infos({})
        expect(match_users.count).to eq 7
      end
      it "should not find all female user infos" do
        @male = create(:male_user_info, destination: "北京 天安门")
        match_users = @male.find_match_user_infos({})
        expect(match_users.count).to eq 10
      end
    end
  end
end
