class UsersController < ApplicationController
load_and_authorize_resource
  skip_before_filter :redirect_to_login, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to welcome_path, notice: "Hi #{@user.name}, thanks for signing up." 
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])

    redirect_to @user

  end
  
end
