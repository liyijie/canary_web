class Api::SessionsController < Devise::SessionsController

  respond_to :json

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    user_info_id = current_user.user_info.blank? ? -1 : current_user.user_info.id
    render :status => 200,
    :json => { :success => true,
      :info => "登录成功",
      :data => { :auth_token => current_user.authentication_token, :user_info_id => user_info_id } }
    end

    def destroy
      authenticate_user_from_token!
      current_user.update_column(:authentication_token, nil)
      render :status => 200,
      :json => { :success => true,
        :info => "注销成功",
        :data => {} }
    end

    def failure
      render :status => 401,
        :json => { :success => false,
        :info => "登录失败",
        :data => {} }
    end
end