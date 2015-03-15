class SmsTokensController < ApplicationController
  def new
  end

  def create
    @sms_token = SmsToken.find_or_initialize_by phone: sms_token_params[:phone]
    token = (0..9).to_a.sample(6).join

    # 发送短信
    company = "旅客"
    ChinaSMS.use :yunpian, password: "e480d5b2daedcd3c0b0d83438ffa01b8"
    result = ChinaSMS.to @sms_token.phone, {company: company, code: token}, {tpl_id: 2}

    @sms_token.token = token

    respond_to do |format|
      if @sms_token.save
        format.html { redirect_to @sms_token, notice: 'SmsToken was successfully created.' }
        format.json { render nothing: true }
      else
        format.html { render :new }
        format.json { render json: @sms_token.errors, status: :unprocessable_entity }
      end
    end


  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
    def sms_token_params
      params.require(:sms_token).permit(
        :phone
        )
    end

end
