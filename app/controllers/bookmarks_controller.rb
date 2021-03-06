class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    if params[:tag]
      tag = Bookmark.order('created_at DESC').tagged_with(params[:tag])
    else
      tag = Bookmark.find(:all, :order => "created_at DESC")
    end

    @bookmarks = params[:user_id] ? Bookmark.order('created_at DESC').where(user_id: params[:user_id]) : tag


    # ? Bookmark.order('created_at').tagged_with(params[:tag]) : Bookmark.find(:all, :order => "created_at")
    # @bookmarks = Bookmark.tagged_with('test1')
    # @bookmarks = Bookmark.all
    @tags = params[:user_id] ? User.find(params[:user_id]).bookmarks.tag_counts_on(:topics) : Bookmark.tag_counts_on(:topics)
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # GET /bookmarks/1/edit
  def edit
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create

    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bookmark }
      else
        format.html { render action: 'new' }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    if current_user == @bookmark.user
          @bookmark.destroy
          respond_to do |format|
              format.html { redirect_to bookmarks_url }
              format.json { head :no_content }
          end
    else
      redirect_to bookmarks_path, notice: 'You can not delete bookmarks that you do not own.'
    end
  end

  def tag_cloud
    @tags = Bookmark.tag_counts_on(:topics)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:name, :url, :topic_list, :user_id)
    end
end
