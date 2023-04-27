class SearchesController < ApplicationController

  def search
    @search_word = params[:search_word]
    @model_name = params[:model_name]
    @method = params[:method]

    if @model_name == "user"
      if @method == "perfect"
        User.where(name: @search_word)
      elsif @method == "forward"
        User.where('name LIKE ?', @search_word + '%')
      elsif @method == "backward"
        User.where('name LIKE ?', '%' + @search_word)
      else
        User.where('name LIKE ?', '%' + @search_word + '%')
      end

    else
      if @method == "perfect"
        Book.where(name: @search_word)
      elsif @method == "forward"
        Book.where('name LIKE ?', @search_word + '%')
      elsif @method == "backward"
        Book.where('name LIKE ?', '%' + @search_word)
      else
        Book.where('name LIKE ?', '%' + @search_word + '%')
      end

    end
  end

end
