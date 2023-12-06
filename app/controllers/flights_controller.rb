class FlightsController < ApplicationController
  before_action :set_trip, only: [:index, :new]

  def index
    @flights = []
    # from=Bali&to=Milan&dates=2023-12-11+to+2023-12-14
    if params[:from].present? && params[:to].present? && params[:dates].present?
      dates = params[:dates].split('to')
      if Flight.where(start_location: params[:from], end_location: params[:to], start_date: dates[0], end_date: dates[1]).none?
        5.times do
          Flight.create!(start_location: params[:from],
                        end_location: params[:to],
                        start_date: dates[0],
                        end_date: dates[1],
                        start_time: Faker::Time.between(from: DateTime.parse(dates[0]), to: DateTime.parse(dates[0]).end_of_day),
                        end_time: Faker::Time.between(from: DateTime.parse(dates[1]), to: DateTime.parse(dates[1]).end_of_day),
                        price: Faker::Number.number(digits: 3))
        end
      end
      @flights = Flight.where(start_location: params[:from], end_location: params[:to], start_date: dates[0], end_date: dates[1])
    end
  end

  def new
    flight = Flight.find(params[:flight_id])
    if FlightStatus.create!(flight: flight, trip: @trip, status: "planned", adult: params[:ppl])
      redirect_to overview_path(id: @trip, query: ""), notice: 'Flight was successfully added.'
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
