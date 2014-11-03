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

class Relation < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"

  validates_presence_of :follower_id
  validates_presence_of :followed_id
end
