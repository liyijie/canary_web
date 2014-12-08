class UserInfosController < ApplicationController

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_user_info, only: [:show, :edit, :update, :destroy, :follow]

  before_action :convert_format, only: [ :create, :update ]

  # GET /user_infos
  # GET /user_infos.json
  def index
    current_user_info = current_user.user_info
    @user_infos = current_user_info.find_match_user_infos(params)
  end

  # GET /user_infos/following
  # GET /user_infos/following.json
  def following
    @users = current_user.following.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /user_infos/followers
  # GET /user_infos/followers.json
  def followers
    @users = current_user.followers.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /user_infos/1/follow
  # GET /user_infos/1/follow.json
  def follow
    followed = @user_info.user
    current_user.follow! followed
  end

  # GET /user_infos/1
  # GET /user_infos/1.json
  def show
  end

  # GET /user_infos/new
  def new
    @user_info = UserInfo.new
  end

  # GET /user_infos/1/edit
  def edit
  end

  # POST /user_infos
  # POST /user_infos.json
  def create
    @user_info = current_user.user_info || current_user.build_user_info
    @user_info.update_attributes(user_info_params)

    respond_to do |format|
      if @user_info.save
        format.html { redirect_to @user_info, notice: 'User info was successfully created.' }
        format.json { render :show, status: :created, location: @user_info }
      else
        format.html { render :new }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_infos/1
  # PATCH/PUT /user_infos/1.json
  def update
    respond_to do |format|
      if valid?(@user_info) && @user_info.update(user_info_params)
        format.html { redirect_to @user_info, notice: 'User info was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_info }
      else
        format.html { render :edit }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_infos/1
  # DELETE /user_infos/1.json
  def destroy
    @user_info.destroy
    respond_to do |format|
      format.html { redirect_to user_infos_url, notice: 'User info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_info
      @user_info = UserInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_info_params
      params.require(:user_info).permit(
        :sex, :nickname, :birth, :destination, :hotel_type, :flight, :train,
        :wechat, :qq, :avatar
        )
    end

    def valid?(user_info)
      user_info.user_id == current_user.id
    end

    def convert_format
      file = params[:user_info][:avatar]
      if !file.blank? && file.present? && file.content_type == 'application/octet-stream'
        mime_type = MIME::Types.type_for(file.original_filename)    
        file.content_type = mime_type.first.content_type if mime_type.first
      end
      params[:user_info][:avatar] = file
    end
end
