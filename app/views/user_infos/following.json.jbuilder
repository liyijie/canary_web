json.set! :total_pages, @user_infos.total_pages
json.set! :current_page, @user_infos.current_page
json.user_infos(@user_infos) do |user_info|
  json.extract! user_info, :id, :sex, :nickname, :age, :constellation
end
