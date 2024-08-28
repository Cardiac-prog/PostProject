class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user.present?        # only signed in users can comment i.e authorizwd users can comment only(the one's signed in)
  end

  def update?
    user.admin? || comment.user == user      # user.admin? --> admin can update any comment
  end                                        #  comment.user == user  --> For user, he/she must be the owner of comment

  def edit?
    update?           # If user can update comment then he/she can also edit it
  end

  def destroy?
    user.admin? || comment.user == user      # admin can destroy, only the user that is owner of comment can destroy it
  end

  class Scope < ApplicationPolicy::Scope           # it is defined which posts a user can access
  end
end
