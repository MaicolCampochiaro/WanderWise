class HotelsController < ApplicationController
  before_action :set_trip_id, only: [:index, :show]
  before_action :set_trip, only: [:index, :show]

  def index
    @hotels = Hotel.where(location: @trip.location)
  end

  def show
    @hotel = Hotel.find(params[:id])
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
end
