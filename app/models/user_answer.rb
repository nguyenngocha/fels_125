class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :word
  belongs_to :answer
  belongs_to :lesson
end
