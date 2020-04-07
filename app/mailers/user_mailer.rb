class UserMailer < ApplicationMailer
  default :from => "splutter_app@mail.com"

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation", template: "account_activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
