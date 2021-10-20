class AlbumsController < ApplicationController
    before_action :find_album, only: [:show, :edit, :update, :destroy]

    def index
      @albums = Album.all.order("created_at DESC")
    end

    def new
      @album = Album.new
    end

    def show
    end

    def create
      @album = Album.new(album_params)

      if @album.save
        redirect_to root_path
      else 
        render 'new'
      end
    end

    private

    def album_params
      params.require(:album).permit(:title, :description, :artist)
    end

    def find_album
      @album = Album.find(params[:id])
    end
end
