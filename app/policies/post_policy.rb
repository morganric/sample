  class PostPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @post = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def categories?
    true
  end

  def admin?
    @current_user.admin? or @current_user.signed_in?
  end

   def create?
    @current_user.admin? or @current_user.signed_in?
  end

  def edit?
    @current_user.admin? or @current_user == @post.user
  end

  def update?
    true
    # @current_user.admin? or @current_user == @piece.user
  end

  def destroy?
    # return false if @current_user == @post.user
    @current_user.admin?
  end

end
