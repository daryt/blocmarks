class Bookmark < ActiveRecord::Base
  acts_as_taggable_on :topics
  belongs_to :user
end
