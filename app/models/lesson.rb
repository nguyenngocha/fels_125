class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :user_answers, dependent: :destroy
  has_many :words, through: :user_answers

  accepts_nested_attributes_for :user_answers, allow_destroy: true

  def build_user_answers
    words = category.words.order("RANDOM()").limit Settings.lesson.word_limit
    words.each do |word|
      user_answers.create! user: user, category: category, word: word
    end
  end
end
