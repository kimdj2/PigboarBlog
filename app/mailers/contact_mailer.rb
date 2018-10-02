class ContactMailer < ApplicationMailer
    def contact_me(contact)
        @contact = contact
        subject = @contact.email + "⇛" + @contact.name + "からのメッセージが届いています。"
        mail to: "1222kdj@gmail.com", from: "nofication@pigboar.com", subject: subject, body: @contact.message
    end

    def contact_me_self
        mail to: "1222kdj@gmail.com", from: "1222kdj@gmail.com",subject: "self", body: "selftest"
    end

end
