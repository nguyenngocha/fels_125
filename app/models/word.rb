class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :lessons, through: :user_answers

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :reject_answers

  validates_presence_of :question
  validate :at_least_one_correct_answer

  scope :all_words, -> (user, category) { where(category_id: category.id) }
  scope :learned, -> (user, category) { joins(:lessons)
    .where(lessons: {user_id: user.id}, category_id: category.id)
    .merge(UserAnswer.correct_user_answers).distinct }
  scope :not_learned, -> (user, category) { where(category_id: category.id)
    .where.not id: Word.learned(user, category) }

  scope :all_words_all_categories, -> (user) {}
  scope :learned_all_categories, -> (user) {joins(:lessons)
    .where(lessons: {user_id: user.id})
    .merge(UserAnswer.correct_user_answers).distinct }
  scope :not_learned_all_categories, -> (user) { where.not id: Word.learned_all_categories(user) }

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
