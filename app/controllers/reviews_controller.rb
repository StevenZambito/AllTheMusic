class ReviewsController < ApplicationController
  before_action :find_album
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def new
    # if current_user.reviews.exists?
    #   redirect_to album_path(@album), notice: "You've already written a review for this book!"
    # else
      @review = Review.new
    # end
  end

  def create
    @review = Review.new(review_params)
    @review.album_id = @album.id
    @review.user_id = current_user.id

    if @review.rating == nil
      redirect_to new_album_review_path, alert: "Need to give review a rating!"
    else
      if @review.save
        redirect_to album_path(@album)
      else
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to album_path(@album)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to album_path(@album)
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment, :title)
  end

  def find_album
    @album = Album.find(params[:album_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
