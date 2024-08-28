class PostPolicy < ApplicationPolicy
  attr_reader :user, :post     # This allows user and post attributes to be accessed in this class

  def initialize(user, post)
    @user = user
    @post = post
  end

  def edit?
    user.admin? || post.user_id == user.id     # user.admin?  is the user is admin he can edit
  end                                          # post.user_id == user.id   if the user's id match the Post'd user_id i.e. user_id that created the post

  def update?
    edit?                           # It goes to edit? methodand in edit? it is checked whether the user can edit or not. In short the user who can edit can also update
  end

  def destroy?
    user.admin? || post.user_id == user.id
  end
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as


  class Scope < ApplicationPolicy::Scope          # it is defined which posts a user can access
  end
end
