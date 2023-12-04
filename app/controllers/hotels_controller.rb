class HotelsController < ApplicationController
  def index
    @trip_id = params[:id]

    if params[:query].present?
      hotel_found = Hotel.where('name ILIKE ?', "%#{params[:query]}%")
      @hotels = hotel_found
    else
      @hotels = Hotel.all
    end

    respond_to do |format|
      format.html
      format.text { render partial: "shared/hotels_list", locals: { locations: @locations }, formats: [:html] }
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
  end
end
