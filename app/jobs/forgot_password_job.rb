class ForgotPasswordJob < ApplicationJob
  queue_as :mailers

  def perform(user, token)
    UserMailer.reset_password_instructions(user, token).deliver_now
  end
end
