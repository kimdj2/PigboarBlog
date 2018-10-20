class ContactController < ApplicationController
  #お問い合わせモデルを生成する。
  def new
    @contact = Contact.new
    render 'contact/contact'
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
      # 例外が発生した場合
      # ログを出力する。
      ErrorUtility.errorLogger(e,"メール送信に失敗")
      # jsonフォーマットに返す（ajax処理のため）
      format.json { render json: {error:"送信エラー"}, status: 400 }
    end
  end
  
  private
  #パラメータを設定する。
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
