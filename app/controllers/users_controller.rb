class UsersController < ApplicationController
  
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @chatroom = @user.chatrooms.order("created_at DESC")
  end
  
  def index
      
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      @user.errors.full_messages.each do |msg|
        flash[:alert] = msg
      end
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the My Blog #{@user.username}, you have successfully signed up"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to root_path
  end
  
  
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
  def require_same_user
    if current_user != User.find(params[:id])
      flash[:alert] = "You can only edit or delete your own user"
      redirect_to User.find(params[:id])
    end
  end
  
  
  
end