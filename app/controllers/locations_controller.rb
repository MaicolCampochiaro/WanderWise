class LocationsController < ApplicationController
  def index
    if params[:query].present?
      @locations = Location.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @locations = Location.all
      # The `geocoded` scope filters only flats with coordinates
      @markers = @locations.geocoded.map do |location|
        {
          lat: location.latitude,
          lng: location.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: { location: location }),
          marker_html: render_to_string(partial: "marker",locals: { location: location })
        }
      end
    end

    respond_to do |format|
      format.html
      format.text { render partial: "shared/homepage_location_cards", locals: { locations: @locations }, formats: [:html, :txt] }
    end
  end
end
