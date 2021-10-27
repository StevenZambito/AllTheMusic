class ReviewsController < ApplicationController
  before_action :find_album
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.album_id = @album.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to album_path(@album)
    else
      render 'new'
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_album
    @album = Album.find(params[:album_id])
  end
end
