class LocationsController < ApplicationController
  def index
    @trip_id = params[:id]

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
end
