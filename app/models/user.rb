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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include ActiveModel::Validations

  attr_accessor :sms_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:phone]

  validates_uniqueness_of :phone
  validates_presence_of :phone

  validate :sms_token_validate

  def sms_token_validate
    sms_token_obj = SmsToken.find_by(phone: phone)
    if sms_token_obj.try(:updated_at) < Time.zone.now - 5.minute
      errors.add(:info, '验证码已失效，请重新获取')
    elsif sms_token_obj.try(:token) != sms_token 
      errors.add(:info, '验证码不正确，请重试')
    end
  end

  has_many :relations, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relations, class_name: "Relation", :foreign_key => "followed_id", dependent: :destroy
  has_many :following, through: :relations, source: :followed
  has_many :followers, through: :reverse_relations, source: :follower
  has_one :user_info, dependent: :destroy

  before_save :ensure_authentication_token

  def follow! followed
    self.relations.find_or_create_by! followed_id: followed.id
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

   def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end


end
