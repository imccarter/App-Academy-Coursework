class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.cat_id = params[:cat_rental_request][:cat_id]
    # fail
    if @cat_rental_request.save
       redirect_to cat_url(@cat_rental_request.cat)
    else
      flash[:errors] = @cat_rental_request.errors.messages
      redirect_to cat_url(@cat_rental_request.cat)
    end
  end

  def destroy
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.destroy!
    render :index
  end

  def index
    render :index
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date)
  end


end
