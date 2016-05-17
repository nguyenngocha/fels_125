class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action only: [:edit, :update, :destroy] {
    @word = load_object Word
  }

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

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash.now[:success] = t "word_updated"
      redirect_to [:admin, @word.category]
    else
      flash.now[:danger] = t "word_update_failed"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "word_deleted"
    else
      flash[:danger] = t "word_delete_failed"
    end
    redirect_to :back
  end

  private
  def word_params
    params.require(:word).permit :question, :category_id,
      answers_attributes: [:id, :answer, :is_correct, :_destroy]
  end
end
