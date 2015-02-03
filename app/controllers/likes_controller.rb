class LikesController < ApplicationController

  #def index
   # @likes =  current_user.likes.order('created_at DESC')
  #end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      flash[:notice] = "Liked Bookmark"
      redirect_to [@bookmark]
    else
      flash[:error] = "Unable to like bookmark.  Please try again."
      redirect_to [@bookmark]
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

    if like.destroy
      flash[:notice] = "Unliked"
      redirect_to [@bookmark]
    else
      flash[:error] = "Unable to unlike bookmark.  Please try again."
      redirect_to [@bookmark]
    end
  end
end
