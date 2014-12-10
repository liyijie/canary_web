json.set! :total_pages, @users.total_pages
json.set! :current_page, @users.current_page
json.user_infos(@users) do |user|
  json.extract! user.user_info, :id, :sex, :nickname, :age, :constellation
end
