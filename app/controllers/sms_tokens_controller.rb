class SmsTokensController < ApplicationController
  def new
  end

  def create
    sms_token = SmsToken.new sms_token_params
    token = (0..9).to_a.sample(6).join

    # 发送短信
    company = "旅客"
    ChinaSMS.use :yunpian, password: "e480d5b2daedcd3c0b0d83438ffa01b8"
    result = ChinaSMS.to phone, {company: company, code: code}, {tpl_id: 2}

    sms_token.token = token
    sms_token.save
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
    def sms_token_params
      params.require(:sms_token).permit(
        :phone
        )
    end

end
