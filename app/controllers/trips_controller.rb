class TripsController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def index
    @trip = trip.all
  end

  def new
    @activity = trip.new
  end

  def create
    @trip = trip.new(trip_params)

    if @activity.save
      redirect_to @trip, notice: 'Trip was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @trip.destroy
    redirect_to activities_url, notice: 'Trip was successfully destroyed.'
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :description, :address, :date, :price)
  end
end
