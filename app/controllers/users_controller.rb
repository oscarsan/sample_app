class UsersController < ApplicationController
  attr_accessor :name, :email
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
  end

  def new
    if !signed_in?
      @user = User.new
    else
      flash[:error] = 'User signed in, can´t create new'
      redirect_to root_url
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 20).order('name ASC')
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    if !signed_in? 
      @user = User.new(user_params)    # Not the final implementation!
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
    else
        flash[:error] = 'User signed in, can´t create new'
        redirect_to root_url
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    usertodestroy = User.find(params[:id])
    if (current_user == usertodestroy)
      flash[:error] = 'Can´t delete own user'
    else
      usertodestroy.destroy
      flash[:success] = "User destroyed. ID: #{usertodestroy.name}"
      redirect_to users_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
 
     # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) 
        sign_out
        redirect_to(root_url)
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
