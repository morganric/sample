
class UsersController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized

  def index
    @users = User.all.order("created_at DESC").page params[:page]
    # authorize User


    @clips = 0
    @views = 0
    @plays = 0
    @uploads = Post.all.count
    @accounts = User.all
  
    Post.all.each do |post|
      @clips = @clips + post.samples.lines.count.to_i
      @plays = @plays + post.plays.to_i     
      @views = @views + post.views.to_i
    end



  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :name, :code)
  end

end
