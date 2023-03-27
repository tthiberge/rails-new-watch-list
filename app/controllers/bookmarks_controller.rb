class BookmarksController < ApplicationController
  # def new
  #   @bookmark = Bookmark.new
  #   @list = List.find(params[:list_id])
  # end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    # @movie = Movie.find(params[:movie_id]) # Avec ces deux lignes ça ne marchait, pas
    # @bookmark.movie = @movie # Pas sûr de comprendre pourquoi!
    # raise
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @bookmark = Bookmark.new
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id]) # Attention ici ce n'est pas les strong_params qu'on appelle!
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
