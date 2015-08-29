class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
    @cat_rental_requests = @cat.rental_requests.order(:start_date)
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      render :show
    else
      redirect_to new_cat_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      render :show
    else
      redirect_to cats_url
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :description, :color, :sex, :birth_date)
  end

end
