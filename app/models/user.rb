class User < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :categories, through: :lessons
  has_many :active_relationships, Relationship.class.name,
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, Relationship.class.name,
    foreign_key: "followed_id",
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
