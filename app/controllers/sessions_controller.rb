class SessionsController < ApplicationController

  def new
    @housekeeper = Housekeeper.new
  end

  def create
    @housekeeper = Housekeeper.find_by_credentials(
      params[:housekeeper][:phone],
      params[:housekeeper][:password])
    if @housekeeper
      login!(@housekeeper)
      redirect_to appointments_url
    else
      flash.now[:errors] = ["Incorrect Phone Number/Password"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
