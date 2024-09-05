class UserMailer < ApplicationMailer
  helper :application
  include Devise::Controllers::UrlHelpers

  def reset_password_instructions(user, token)
    @token = token
    mail(to: user.email, subject: "Reset your password")
  end
end
