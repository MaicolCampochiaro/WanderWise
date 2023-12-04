class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :set_trip_id, only: [:index, :show, :edit, :update, :destroy]

  def homepage
  end

  def index
    if params[:query].present?
      @trips = Trip.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @trips = Trip.all
    end
  end

  def show
    if params[:query].present?
      detail = params[:query].split('=') # detail[0] = location_id, detail[1] = 1
      update(detail)
      puts "UPDATE CONFIRM !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    end
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

  def update(detail)
    case detail[0]
    when 'location_id'
      reference = Location.find(detail[1])
    when 'flight_id'
      reference = Flight.find(detail[1])
    when 'hotel_id'
      reference = Hotel.find(detail[1])
    when 'activity_id'
      reference = Activity.find(detail[1])
    end
    redirect_to request.referrer, alert: 'There was a problem, try again.' unless @trip.update( detail[0].to_sym => reference.id)
  end

  def destroy
    @trip.destroy
    redirect_to homepage_path, notice: 'Trip was successfully deleted.'
  end

  private

  def set_trip_id
    @trip_id = params[:id]
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def flight_params
    params.require(:flight_statuses).permit(:adult, :status,)
  end
end
