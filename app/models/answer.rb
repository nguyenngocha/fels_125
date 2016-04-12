class Answer < ActiveRecord::Base
  belongs_to :word

  has_many :user_answers, dependent: :destroy
end
