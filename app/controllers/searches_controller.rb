class SearchesController < ApplicationController

  def search
    @search_word = params[:search_word]
    @model_name = params[:model_name]
    method = params[:method]

    if @model_name == "user"
      @users = User.search_for(method, @search_word)
    else
      @books = Book.search_for(method, @search_word)
    end
  end

end
