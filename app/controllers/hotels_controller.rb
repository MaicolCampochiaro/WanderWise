class HotelsController < ApplicationController
  before_action :set_trip_id, only: [:index, :show, :new]
  before_action :set_trip, only: [:index, :show, :new]

  def index
    @hotels = Hotel.where(location: @trip.location)
    @markers = @hotels.geocoded.map do |hotel|
      {
        lat: hotel.latitude,
        lng: hotel.longitude,
        # info_window_html: render_to_string(partial: "maps/info_window", locals: { location: location }, formats: [:html]),
        marker_html: render_to_string(partial: "maps/marker", locals: { marker: hotel }, formats: [:html])
      }
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
    @room_statuses = @hotel.room_statuses
  end

  def new
    room_status = RoomStatus.find(params[:room_id])
    if room_status.present?
      if RoomStatus.update(trip: @trip, status: "planned")
        redirect_to overview_path(trip_id: @trip, query: ""), notice: 'Hotel was successfully added.'
      else
        redirect_to request.referer || "/", alert: 'There was a problem, try again.'
      end
    else
      # Handle the case where the room status is not found
      redirect_to request.referer || "/", alert: 'Room status not found for the given hotel.'
    end
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
