class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :likes, dependent: :destroy
  has_many :bookmarks

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end

  def sorted_likes
    bookmark_ids = likes.collect { |like| like.bookmark_id }
    Bookmark.where('id IN (?)', bookmark_ids).order('created_at DESC')
  end

  acts_as_tagger
  
end
