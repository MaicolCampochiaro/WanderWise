class ApplicationController < ActionController::Base
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || trips_path
  end
end
