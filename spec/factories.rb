FactoryGirl.define do  factory :sms_token do
    phone "MyString"
token "MyString"
  end
 
  factory :user_info do
    sex :male
    nickname "MyString"
    birth Date.new(2007, 5, 12)
    destination "杭州"
    hotel_type 2
    flight "MyString"
    train "MyString"
    wechat "MyString"
    qq "MyString"
  end

  factory :male_user_info, class: UserInfo do
    sex :male
    nickname "MyString"
    birth Date.new(2007, 5, 12)
    destination "北京"
    hotel_type 3
    flight "MyString"
    train "MyString"
    wechat "MyString"
    qq "MyString"
    user_id 3
  end

  factory :female_user_info, class: UserInfo do
    sex :female
    nickname "MyString"
    birth Date.new(2007, 5, 12)
    destination "北京天安门"
    hotel_type 2
    flight "MyString"
    train "MyString"
    wechat "MyString"
    qq "MyString"
    user_id 4
  end

  factory :user do
    phone "13818181888"
    password "password"
    password_confirmation "password"
  end

  factory :followed_user, class: User do
    phone "13819191919"
    password "password"
    password_confirmation "password"
  end
end