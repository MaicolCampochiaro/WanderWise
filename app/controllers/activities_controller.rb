class ActivitiesController < ApplicationController
  before_action :set_trip_id, only: [:index, :create, :show]
  before_action :set_trip, only: [:index, :create, :show]

  def index
  end

  def show
  end

  def create
    activity = Activity.find(params[:activity_id])
    date = params[:date]
    if ActivityStatus.create!(activity: activity, trip: @trip, status: "planned", date: date, participant: 2)
      redirect_to overview_path(trip_id: @trip, query: ""), notice: 'Activity was successfully added.'
    else
      redirect_to request.referrer, alert: 'There was a problem, try again.'
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
