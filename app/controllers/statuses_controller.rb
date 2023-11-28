class StatusesController < ApplicationController
  before_action :set_activity
  before_action :set_activity_status, only: [:show, :create, :update, :destroy]

  def index
    @activity_statuses = @activity.activity_statuses
  end

  def show
  end

  def create
    @activity_status = @activity.activity_statuses.new(activity_status_params)

    if @activity_status.save
      redirect_to activity_activity_statuses_path(@activity), notice: 'Activity status was successfully created.'
    else
      render :index
    end
  end

  def update
    if @activity_status.update(activity_status_params)
      redirect_to activity_activity_statuses_path(@activity), notice: 'Activity status was successfully updated.'
    else
      render :index
    end
  end

  def destroy
    @activity_status.destroy
    redirect_to activity_activity_statuses_path(@activity), notice: 'Activity status was successfully destroyed.'
  end

  private

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_activity_status
    @activity_status = ActivityStatus.find(params[:id])
  end

  def activity_status_params
    params.require(:activity_status).permit(:status, :trip_id)
  end
end
