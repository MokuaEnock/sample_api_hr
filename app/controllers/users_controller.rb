class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    # Hash the password using bcrypt
    @user.password = BCrypt::Password.create(params[:user][:password])

    if @user.save
      role = Role.find_by(name: "employer")

      @user.roles << role
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
