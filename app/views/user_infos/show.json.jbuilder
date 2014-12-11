json.extract! @user_info, :id, :sex, :nickname, :age, :destination, :hotel_type, :flight, :train 
json.image_thumb image_url(@user_info.avatar.url(:thumb)) if @user_info.avatar
json.image_large image_url(@user_info.avatar.url(:medium)) if @user_info.avatar
# if current user show his/her own user information
# or current user is following the user before
if @user_info.user_id == current_user.id || current_user.following?(@user_info.user)
  json.qq @user_info.qq
  json.wechat @user_info.wechat
end
