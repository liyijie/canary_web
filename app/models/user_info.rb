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

  def find_match_user_infos
    match_sex =  self.sex == "male" ? "female" : "male"
    search_text = self.destination.sub("市", " ").sub("省"," ")
    search_contents = search_text.split(" ")
    return [] if search_contents.blank?

    users = UserInfo.search do
      with :sex, match_sex
      fulltext search_contents.join(" OR ")
      if match_sex == "male"
        with(:hotel_type).greater_than_or_equal_to self.hotel_type
      else
        with(:hotel_type).less_than_or_equal_to self.hotel_type
      end
    end
    users.results
  end
end
