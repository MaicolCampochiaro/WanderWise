class LocationsController < ApplicationController
  def index
    if params[:query].present?
      @locations = Location.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @locations = Location.all
    end

    respond_to do |format|
      format.html
      format.text { render partial: "shared/homepage_location_cards", locals: { locations: @locations }, formats: [:html, :txt] }
    end
  end
end
