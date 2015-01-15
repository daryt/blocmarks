class LikesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      flash[:notice] = "Liked Bookmark"
      redirect_to [@bookmark]
    else
      flash[:error] = "Unable to like bookmark.  Please try again"
      redirect_to [@bookmark]
    end
  end
end
