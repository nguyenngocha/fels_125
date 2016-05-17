class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    @filter_type = params[:filter_type] || Settings.category.filter_type.all_words
    if !params[:category].blank? && !params[:category][:category_id].blank?
      @category = Category.find params[:category][:category_id]
      @words = Word.includes(:answers).send(@filter_type, current_user, @category)
    else
      @filter_type_all_categories = "#{@filter_type}_all_categories"
      @words = Word.includes(:answers).send(@filter_type_all_categories, current_user)
    end
    @words = @words.paginate page: params[:page]
  end
end
