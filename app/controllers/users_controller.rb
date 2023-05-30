class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "アカウント登録が完了しました"
      redirect_to dashboard_path
    else
      flash[:danger] = "アカウント登録に失敗しました"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms
  end

  def update
    @user = current_user
    if @user.update_attribute(current_user_params.keys.first, current_user_params.values.first)
      flash[:notice] = "保存しました"
    else
      flash[:alert] = "更新できません"
    end
    redirect_to dashboard_path(@user)
  end

  private

  def current_user_params
    params.require(:user).permit(:about, :avatar, :name, :password, :password_confirmation, :email)
  end

end
