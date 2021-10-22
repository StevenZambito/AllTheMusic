class AlbumsController < ApplicationController
    before_action :find_album, only: [:show, :edit, :update, :destroy]
    include ActiveModel::AttributeAssignment
    include ActiveModel::Validations

    def index
      @albums = Album.all.order("created_at DESC")
    end

    def new
      @album = current_user.albums.build
      @genres = Genre.all.map{ |g| [g.name, g.id]}
    end

    def show
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
    end

    def update
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
      params.require(:album).permit(:title, :description, :artist, :genre_id)
    end

    def find_album
      @album = Album.find(params[:id])
    end
end
