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

class UserInfo < ActiveRecord::Base
  enum sex: [ :male, :female ]

  belongs_to :user

  searchable do
    integer :user_id
    string :sex
    integer :hotel_type
    text :destination
  end
end
