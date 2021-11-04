class AlbumsController < ApplicationController
    before_action :find_album, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]

    def index
      if params[:genre].blank?
        @albums = Album.search(params[:search])
      else
        @genre_id = Genre.find_by(name: params[:genre]).id
        @albums = Album.where(:genre_id => @genre_id).order("created_at DESC")
      end
    end

    def new
      @album = current_user.albums.build
      @genres = Genre.all.map{ |g| [g.name, g.id]}
    end

    def show
      if @album.reviews.blank?
        @average_review = 0
      else
        @average_review = @album.reviews.average(:rating).round(2)
      end

    end

    def create
      @album = current_user.albums.build(album_params)
      @album.genre_id = params[:genre_id]

      if @album.save
        redirect_to root_path
      else 
        render 'new'
      end
    end

    def edit
      @genres = Genre.all.map{ |g| [g.name, g.id]}
    end

    def update
      @album.genre_id = params[:genre_id]
      if @album.update(album_params)
        redirect_to album_path(@album)
      else
        render 'edit'
      end

    end

    def destroy
      @album.destroy
      redirect_to root_path

    end

    private

    def album_params
      params.require(:album).permit(:title, :description, :artist, :genre_id, :album_cover, :release_date, :label)
    end

    def find_album
      @album = Album.find(params[:id])
    end
end
