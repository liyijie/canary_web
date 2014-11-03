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
end
