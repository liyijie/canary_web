class AddPhoneIndexToSmsToken < ActiveRecord::Migration
  def change
    add_index :sms_tokens, :phone
  end
end
