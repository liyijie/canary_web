json.set! :total_pages, @users.total_pages
json.set! :current_page, @users.current_page
json.user_infos(@users) do |user|
  json.extract! user.user_info, :id, :sex, :nickname, :age, :constellation
  json.image_thumb image_url(user_info.avatar.url(:thumb)) if user.user_info.avatar
  json.image_large image_url(user_info.avatar.url(:medium)) if user.user_info.avatar
end
