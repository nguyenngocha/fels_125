class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  
  def create
    @word = Word.new word_params
    @category = Category.find params[:word][:category_id]
    if @word.save
      flash[:success] = t "word_added"
      redirect_to :back
    else
      flash[:danger] = t "word_add_failed"
      redirect_to :back
    end
  end

  private
  def word_params
    params.require(:word).permit :question, :category_id,
      answers_attributes: [:id, :answer, :is_correct, :_destroy]
  end
end
