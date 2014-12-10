json.set! :total_pages, @user_infos.blank? ? 1 : @user_infos.total_pages
json.set! :current_page, @user_infos.blank? ? 1 : @user_infos.current_page
json.user_infos(@user_infos) do |user_info|
  json.extract! user_info, :id, :sex, :nickname, :age, :constellation
  json.image_thumb image_url(user_info.avatar.url(:thumb)) if user_info.avatar
  json.image_large image_url(user_info.avatar.url(:medium)) if user_info.avatar
end
