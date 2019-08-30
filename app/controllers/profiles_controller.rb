class ProfilesController < ApplicationController
  def dashboard
    @user = current_user
    @markersUser = []
    @markerLocal = {
      lat: @user.latitude,
      lng: @user.longitude,
      infoWindow: render_to_string(partial: "info_window_map", locals: { name: "You", place_type: "This is your location!" })
    }
  end
end
