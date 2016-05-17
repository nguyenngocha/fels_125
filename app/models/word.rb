class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :lessons, through: :user_answers

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :reject_answers

  validates_presence_of :question
  validate :at_least_one_correct_answer

  scope :words, lambda {
    find_by_sql("SELECT DISTINCT * FROM words WHERE words.id NOT IN
      (SELECT DISTINCT words.id FROM words, user_answers WHERE words.id = word_id)")
  }

  private
  def reject_answers (attributed)
    attributed['answer'].blank?
  end

  def at_least_one_correct_answer
    valid = false
    answers.each do |answer|
      valid = answer.is_correct? ? true : valid unless answer.
        marked_for_destruction?
    end
    errors.add :answers, I18n.t("at_least_one_correct_answer") unless valid
  end
end
