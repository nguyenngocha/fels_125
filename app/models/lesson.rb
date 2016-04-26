class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :user_answers, dependent: :destroy
  has_many :words, through: :user_answers
  
  def build_user_answers
    words = category.words.order("RANDOM()").limit 10
    words.each do |word|
      user_answer = user_answer.create word: word
    end
  end
end
