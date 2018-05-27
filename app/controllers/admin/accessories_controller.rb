class Admin::AccessoriesController < Admin::BaseController

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    if @accessory.save
      flash[:success] = "#{@accessory.title} Created!"
      redirect_to accessory_path(@accessory)
    else
      render :new
    end
  end
  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :image, :price)
  end
end
