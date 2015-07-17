class BandsController < ApplicationController
  def new

  end

  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new
    render :new
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end
