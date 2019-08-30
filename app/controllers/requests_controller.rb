class RequestsController < ApplicationController
  before_action :set_user, only: [:index, :create, :show]

  def index
    @requests = Request.where(user_id: @user.id)
    @matches = []
    @requests.each do |request|
      params[:selected_recipes].each do |selected_recipe|
        requests = Request.find_by(recipe_id: selected_recipe.to_i)
        @matches << requests if requests[:user_id] != @user.id
      end
    end

    @markersUser = @matches.map do |m|
      user = User.find_by(id: m.user_id)
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window_map", locals: { name: user.first_name + " " + user.last_name, place_type: "Meetup" })
      }
    end

    local_user = User.find_by(id: @user.id)
    @markerLocal = {
      lat: local_user.latitude,
      lng: local_user.longitude,
      infoWindow: render_to_string(partial: "info_window_map", locals: { name: "You", place_type: "This is your location!" })
    }
  end
end
