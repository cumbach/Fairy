class AppointmentsController < ApplicationController

  def index
    @appointments = current_housekeeper.appointments
  end

  def new
    @appointments = Appointment.filter(current_housekeeper)
  end

  def create
    @appointment = current_housekeeper.appointments.new(appointment_params)
    if @appointment.save
      redirect_to appointment_url(@appointment)
    else
      flash.now[:errors] = @appointment.errors.full_messages
      render :new
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_url
    else
      flash.now[:errors] = @appointment.errors.full_messages
      render :new
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:address, :scheduled_at, :start_at, :end_at, :housekeeper_id)
  end

end
