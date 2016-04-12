class Relationship < ActiveRecord::Base
  belongs_to :follower, User.name
  belongs_to :followed, User.name
end
