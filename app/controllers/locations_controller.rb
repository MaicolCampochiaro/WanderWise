class LocationsController < ApplicationController
  before_action :set_trip, only: [:index, :create_location]
  def index
    if params[:query].present?
      location_found = Location.where('name ILIKE ?', "%#{params[:query]}%")
      @locations = location_found
    else
      @locations = Location.all
    end
    # The `geocoded` scope filters only flats with coordinates
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window_html: render_to_string(partial: "maps/info_window", locals: { location: location }, formats: [:html]),
        marker_html: render_to_string(partial: "maps/marker",locals: { location: location }, formats: [:html])
      }
    end
    respond_to do |format|
      format.html
      format.text { render partial: "shared/locations_list", locals: { locations: @locations }, formats: [:html] }
    end
  end

  def create_location
    reference = nil
    @trip = Trip.find(params[:id])
    if params[:location].present?
      reference = Location.find(params[:location])
    end
    if @trip.update(location: reference)
      redirect_to overview_path(trip_id: @trip, query: ""), notice: 'Trip was successfully created.'
    else
      redirect_to request.referrer, alert: 'There was a problem, try again.'
    end
  end

  private
  def set_trip
    @trip = Trip.find(params[:id])
  end
end
