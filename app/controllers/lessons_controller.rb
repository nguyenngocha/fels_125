class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action except: [:index, :new, :create] {
    @lesson = load_object Lesson
  }

  def create
    @category = Category.find params[:category_id]
    @lesson = current_user.lessons.build category_id: @category.id
    if @lesson.save
      @lesson.build_user_answers
      redirect_to [@category, @lesson]
    else
      flash[:danger] = t "lesson_create_failed"
      redirect_to root_url
    end
  end

  def show
    @lesson = Lesson.find params[:id]
    @words = @lesson.words.distinct
    @user_answers = @lesson.user_answers
  end

  def update
    @lesson.update_attributes lesson_params
    redirect_to categories_path
  end

  private
  def lesson_params
    params.require(:lesson).permit :status, user_answers_attributes: [
      :id, :answer_id, :_destroy]
  end
end
