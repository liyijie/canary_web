# == Schema Information
#
# Table name: relations
#
#  id          :integer          not null, primary key
#  followed_id :integer
#  follower_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Relation, :type => :model do
  before(:each) do
    @follower = create(:user)
    @followed = create(:followed_user)

    @relation = @follower.relations.build(followed_id: @followed.id)
  end

  it "should create a new instance given valid attributes" do
    @relation.save!
  end

  describe "follow methods" do
    before(:each) do
      @relation.save
    end

    it "should have a follower attribute" do
      expect(@relation).to respond_to :follower
    end

    it "should have the right follower" do
      expect(@relation.follower).to eq @follower
    end

    it "should have a followed attribute" do
      expect(@relation).to respond_to :followed
    end

    it "should have the right followed user" do
      expect(@relation.followed).to eq @followed
    end
  end

  describe "validations" do
    it "should require a followed_id" do
      @relation.followed_id = nil
      expect(@relation).to be_invalid
    end

    it "should require a follower_id" do
      @relation.follower_id = nil
      expect(@relation).to be_invalid
    end
  end
end
