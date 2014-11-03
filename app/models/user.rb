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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:phone]

  validates_uniqueness_of :phone
  validates_presence_of :phone

  has_many :relations, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relations, class_name: "Relation", :foreign_key => "followed_id", dependent: :destroy
  has_many :following, through: :relations, source: :followed
  has_many :followers, through: :reverse_relations, source: :follower

  def follow! followed
    self.relations.create! followed_id: followed.id
  end

  def following? followed
    self.relations.find_by_followed_id followed
  end

  def unfollow! followed
    self.relations.find_by_followed_id(followed).destroy
  end

  # user phone as the authentication key, so email is not required default
  def email_required?
    false
  end

end
