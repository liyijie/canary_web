json.extract! @user_info, :id, :sex, :nickname, :age, :destination, :hotel_type, :flight, :train 
json.image_thumb image_url(@user_info.avatar.url(:thumb)) if @user_info.avatar
json.image_large image_url(@user_info.avatar.url(:medium)) if @user_info.avatar
