FactoryGirl.define do
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