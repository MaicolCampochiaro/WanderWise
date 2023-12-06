class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :destroy]
  before_action :set_trip_id, only: [:homepage, :index, :show, :destroy]

  def homepage
  end

  def index
    if params[:query].present?
      @trips = Trip.where('name ILIKE ?', "%#{params[:query]}%")
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
    @trip = Trip.new
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

  def edit
  end

  def destroy
    @trip.destroy
    redirect_to trips_path, notice: 'Trip was successfully deleted.'
  end

  private

  def set_trip_id
    if params[:trip_id].present?
      @trip_id = params[:trip_id]
    else
      @trip_id = params[:id]
    end
  end

  def set_trip
    if params[:trip_id].present?
      @trip = Trip.find(params[:trip_id])
    else
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
