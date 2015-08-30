class AlbumsController < ApplicationController
  def new
    @album = Album.new
    @band = Band.find_by(id: params[:band_id])
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @band = Band.find_by(id: params[:band_id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :studio)
  end
end
