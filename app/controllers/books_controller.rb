class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
  end

  def edit
  end
end
