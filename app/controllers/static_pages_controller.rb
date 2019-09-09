class StaticPagesController < ApplicationController
  def index
    @books = current_user.books if user_signed_in?
  end
end
