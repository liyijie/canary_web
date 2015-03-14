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

require 'rails_helper'

RSpec.describe SmsToken, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
