class ContactController < ApplicationController
  #お問い合わせモデルを生成する。
  def new
    @contact = Contact.new
  end
  
  #メッセージ送信
  def create
    begin
      #入力フォームよりデータを取得する。
      @contact = Contact.new contact_params
      respond_to do |format|
        #バリデーションチェックに問題ない場合
        if @contact.valid?
          #メール送信処理を行う。
          ContactMailer.contact_me(@contact).deliver
          format.js
        #バリデーションチェックに問題が発生した場合
        else
          format.json { render json: @board.errors, status: :unprocessable_entity }
        end
      end
    rescue => e
      ErrorUtility.errorLogger(e,"メール送信に失敗")
      format.json { render json: {error:"送信エラー"}, status: 400 }
    end
  end
  
  private
  
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
