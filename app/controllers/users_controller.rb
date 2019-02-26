class UsersController < ApplicationController

  before_action :authenticate_user!, only:[:index, :edit, :show, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
    @books = Book.all
  end

  def edit
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    # @books = Book.all
    # @books = @books.user
  end

  def top
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "updated successfully"
      redirect_to user_path(@user)
    else
      p @user.errors.any?
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :introduction, :image)
  end

  def correct_user
    @user = User.find(params[:id])
    if  @user != current_user
      redirect_to users_path
    end
  end

end