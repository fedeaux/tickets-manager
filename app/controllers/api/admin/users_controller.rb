class Api::Admin::UsersController < Api::Admin::BaseController
  before_action :set_user, only: [:update]

  def index
    @users = User.where.not(id: current_user.id)
    render '/api/users/index'
  end

  def update
    # Don't let an admin to revoke his/hers own privileges
    if @user.id != current_user.id
      user_attributes = user_params
    else
      user_attributes = user_params.except(:role)
    end

    @user.update user_attributes
    render '/api/users/show'
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :role)
  end
end
