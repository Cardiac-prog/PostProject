class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  include Pundit::Authorization   # Pundti
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized   # Pundit

  include Pagy::Backend  # Pagy

  def after_sign_in_path_for(resource)
    root_path
  end
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # e.g., root_path
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def user_not_authorized(exception)     # This method is called when Pundit raises a Pundit::NotAuthorizedError. It takes the exception object as an argument.
    policy_name = exception.policy.class.to_s.underscore    # This line extracts the name of the policy class that caused the exception. exception.policy.class.to_s converts the policy class to a string (e.g., PostPolicy), and underscore converts it to a lowercase, snake-case string (e.g., post_policy).

    if policy_name.include?("comment")
      # Redirect to the post's path if the unauthorized action is related to a comment
      flash[:alert] = "You're not authorized to perform this action on the comment."
      redirect_back(fallback_location: root_path)
    else
      # Default behavior: Redirect to the root path
      flash[:alert] = "You're not authorized to perform this action."
      redirect_to(root_path)
    end
  end

# Basic Authetication for API
=begin
  def authenticate_user!
    if request.authorization
      authenticate_or_request_with_http_basic do |username, password|
        user = User.find_by(email: username)
        user && user.valid_password?(password)
      end
    else
      authenticate_or_request_with_http_basic
    end
  end
=end
end
