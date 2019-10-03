class UsersController < ApplicationController
  before_action :set_user

  def show
    @books_count = @user.books.count
  end

  private

  def set_user
    @user    = User.find(params[:id])
    @current = current_user.id == @user.id
  end
end
