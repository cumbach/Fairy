class HousekeepersController < ApplicationController

  def new
    if current_housekeeper
      redirect_to appointments_url
    end
    @housekeeper = Housekeeper.new
  end

  def create
    @housekeeper = Housekeeper.new(housekeeper_params)
    if @housekeeper.save
      login!(@housekeeper)
      redirect_to appointments_url
    else
      flash.now[:errors] = @housekeeper.errors.full_messages
      render :new
    end
  end

  private
  def housekeeper_params
    params.require(:housekeeper).permit(:phone, :password)
  end
end
