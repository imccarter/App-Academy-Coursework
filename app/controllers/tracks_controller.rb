class TracksController < ApplicationController
  def new
    @track = Track.new
    @album = Album.find_by(id: params[:album_id])
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    @album = Album.find_by(id: params[:album_id])
    render :show
  end



  private
  def track_params
    params.require(:track).permit(:name, :album_id, :bonus)
  end
end
