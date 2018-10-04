class ContactMailer < ApplicationMailer
    #お問い合わせメール送信
    def contact_me(contact)
        #入力値よりデータを取得する。
        @contact = contact
        #メールタイトルを設定する。
        subject = @contact.name + "様からのメッセージが届いています。"
        #メール設定
        mail to: "1222kdj@gmail.com", from: @contact.email, subject: subject, body: @contact.message
    end
end
