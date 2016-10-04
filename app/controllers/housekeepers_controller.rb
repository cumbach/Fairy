class HousekeepersController < ApplicationController

  def new
    @housekeeper = Housekeeper.new
  end

  def create
    @housekeeper = Housekeeper.new(housekeeper_params)
    if @housekeeper.save
      login!(@housekeeper)
      redirect_to appointments_url
    else
      flash.now[:errors] = ["This Phone Number has already been used to create an account"]
      render :new
    end
  end

  private
  def housekeeper_params
    params.require(:housekeeper).permit(:phone, :password)
  end
end
