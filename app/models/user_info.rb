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

class UserInfo < ActiveRecord::Base
  enum sex: [ :male, :female ]

  belongs_to :user

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  searchable do
    integer :user_id
    string :sex
    integer :hotel_type
    text :destination
  end

  def age
    return "" if birth.blank?
    now = Time.now.utc.to_date
    now.year - birth.year - (birth.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def constellation
    return "" if birth.blank?
    
    year = birth.year
    mon = birth.mon
    day = birth.day

    if Date.new(year, 1, 21) <= birth && birth <= Date.new(year, 2, 19)
      "水瓶座"
    elsif Date.new(year, 2, 20) <= birth && birth <= Date.new(year, 3, 20)
      "双鱼座"
    elsif Date.new(year, 3, 21) <= birth && birth <= Date.new(year, 4, 20)
      "白羊座"
    elsif Date.new(year, 4, 21) <= birth && birth <= Date.new(year, 5, 21)
      "金牛座"
    elsif Date.new(year, 5, 22) <= birth && birth <= Date.new(year, 6, 21)
      "双子座"
    elsif Date.new(year, 6, 22) <= birth && birth <= Date.new(year, 7, 23)
      "巨蟹座"
    elsif Date.new(year, 7, 24) <= birth && birth <= Date.new(year, 8, 23)
      "狮子座"
    elsif Date.new(year, 8, 24) <= birth && birth <= Date.new(year, 9, 23)
      "处女座"
    elsif Date.new(year, 9, 24) <= birth && birth <= Date.new(year, 10, 23)
      "天秤座"
    elsif Date.new(year, 10, 24) <= birth && birth <= Date.new(year, 11, 22)
      "天蝎座"
    elsif Date.new(year, 11, 23) <= birth && birth <= Date.new(year, 12, 22)
      "射手座"
    else
      "摩羯座"
    end
  end

  def find_match_user_infos(params)
    match_sex =  self.sex == "male" ? "female" : "male"
    search_text = self.destination.to_s.sub("市", " ").sub("省"," ")
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
      paginate page: params[:page], per_page: 10
    end
    users.results
  end
end
