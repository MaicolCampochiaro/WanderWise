class TripsController < ApplicationController
  before_action :set_trip, only: [:index, :create, :show, :destroy]

  def homepage
  end

  def index
    if current_user.present?
      @trips = Trip.where(user_id: current_user.id)
    else
      @trips = Trip.all
    end
  end

  # overview route
  def show
    @trip = Trip.find(params[:id])
    @date_range = @trip.date_range
  end

  def new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user if current_user.present?

    if @trip.save!
      redirect_to locations_path(@trip), notice: 'Trip was successfully created.'
    else
      # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! think when u failed to create a trip, what should u do?
      render :new
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path, notice: 'Trip was successfully deleted.'
  end

  private

  def set_trip
    if params[:id].present?
      @trip = Trip.find(params[:id])
    end
  end

  def flight_params
    params.require(:flight_statuses).permit(:adult, :status,)
  end

  def trip_params
    params.permit(:name)
  end
end
