# == Schema Information
#
# Table name: sms_tokens
#
#  id         :integer          not null, primary key
#  phone      :string(255)
#  token      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class SmsToken < ActiveRecord::Base
end
