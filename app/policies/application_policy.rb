# app/policies/application_policy.rb
class ApplicationPolicy
  attr_reader :user, :record     # creates getter method for user and record so they can be accessed in within this class

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false              # this method can be overridden in sub class if they want to
  end

  def show?
    scope.where(id: record.id).exists?    # Determines if the user can view a single record. It checks if the record exists within the scope of accessible records.
  end

  def create?
    false         # this method can be overridden in sub class if they want to
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
