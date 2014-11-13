# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  phone                  :string(255)
#  authentication_token   :string(255)
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "attributes" do
    before(:each) do
      @user = create(:user)
    end
    it "should have a phone method" do
      expect(@user).to respond_to(:phone)
    end

    it "phone atrribute should be unique" do
      @another_user = build(:user)
      expect(@another_user).to be_invalid
    end

    it "phone attribute should not be nil" do
      @user.phone = nil
      expect(@user).to be_invalid
    end
  end

  describe "relations" do
    before(:each) do
      @user = create(:user)
      @followed = create(:followed_user)
    end

    it "should have a relations method" do
      expect(@user).to respond_to :relations
    end

    it "should have a following method" do
      expect(@user).to respond_to :following
    end

    it "should have a following? method" do
      expect(@user).to respond_to :following?
    end

    it "should have a follow! method" do
      expect(@user).to respond_to :follow!
    end

    it "should follow another user" do
      @user.follow! @followed
      expect(@user).to be_following @followed
    end

    it "should include the followd user in the following array" do
      @user.follow! @followed
      expect(@user.following).to include @followed
    end

    it "should have a unfollow! method" do
      expect(@user).to respond_to :unfollow!
    end

    it "should unfollow a user" do
      @user.follow! @followed
      @user.unfollow! @followed
      expect(@user).not_to be_following @followed
    end

    it "should have a reverse_relations method" do
      expect(@user).to respond_to :reverse_relations
    end

    it "should have a followers method" do
      expect(@user).to respond_to :followers
    end

    it "should include the follower in the followers array" do
      @user.follow! @followed
      expect(@followed.followers).to include @user
    end
  end

  describe "authentication token" do
    it "should generate authentication token when user created" do
      @user = build(:user)
      expect(@user.authentication_token).to be_blank
      @user.save!
      expect(@user.authentication_token).not_to be_blank
    end
  end
end
