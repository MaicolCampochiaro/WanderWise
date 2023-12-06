class ActivitiesController < ApplicationController
  before_action :set_trip, only: [:index, :create, :show]

  def index
    @activities = Activity.where(location: @trip.location)
    @markers = @activities.geocoded.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude,
        # info_window_html: render_to_string(partial: "maps/info_window", locals: { location: location }, formats: [:html]),
        marker_html: render_to_string(partial: "maps/marker", locals: { marker: activity }, formats: [:html])
      }
    end
  end

  def show
  end

  def create
    activity = Activity.find(params[:activity_id])
    date = params[:date]
    if ActivityStatus.create!(activity: activity, trip: @trip, status: "planned", date: date, participant: 2)
      redirect_to overview_path(id: @trip, query: ""), notice: 'Activity was successfully added.'
    else
      redirect_to request.referrer, alert: 'There was a problem, try again.'
    end
  end

  private

  def set_trip
    if params[:id].present?
      @trip = Trip.find(params[:id])
    end
  end
end
