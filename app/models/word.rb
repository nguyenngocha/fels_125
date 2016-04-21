class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :lessons, through: :user_answers
end
