FactoryGirl.define do 
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