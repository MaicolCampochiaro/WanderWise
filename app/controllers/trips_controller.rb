class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

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

  def update
    if @trip.update(trip_params)
      redirect_to @trip, notice: 'Trip was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to homepage_path, notice: 'Trip was successfully deleted.'
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.permit(:name)
  end
end
