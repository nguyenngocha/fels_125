class LessonsController < ApplicationController
  def create
    @category = Category.find params[:category_id]
    @lesson = current_user.lessons.build category_id: @category_id
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
    @words = @lesson.words
  end
end
