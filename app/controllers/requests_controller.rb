class RequestsController < ApplicationController
  before_action :set_user, only: [:index, :create, :show]

  def index
    @review = Review.new()
    @requests = Request.where(user: current_user)
    @matches = []
    @requests.each do |request|
      params[:selected_recipes].each do |selected_recipe|
        my_request = Request.find_by(recipe_id: selected_recipe.to_i)

        requests = Request.where(recipe: my_request.recipe)
        requests = requests.where.not(user: current_user)
        requests.each do |other_request|
          if other_request.user != current_user
            @matches << requests
          end
        end
      end
      @matches = @matches.flatten.uniq

      @markersUser = @matches.map do |m|
      user = User.find_by(id: m.user_id)
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window_map", locals: { name: user.first_name, place_type: "Meetup", image: user.image }),
        user: user.id,
        current_user: current_user.id
      }
      end
      local_marker
    end
  end

  def show
    @recipes = []
    params[:recipes].uniq.each { |r| @recipes << Recipe.find(Request.find(r).recipe_id) }
    @recipes = @recipes.uniq


    @meetup = Meetup.new

    user = User.find_by(id: params[:id])
    @markersUser = []
    match_user = {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window_map", locals: { name: user.first_name, place_type: "Meetup", image: user.image }),
        user: user.id,
        current_user: current_user.id
      }
      @markersUser << match_user
    local_marker
  end

  private

  def local_marker
    local_user = User.find_by(id: @user.id)
    @markerLocal = {
      lat: local_user.latitude,
      lng: local_user.longitude,
      infoWindow: render_to_string(partial: "info_window_map", locals: { name: "You", place_type: "This is your location!", image: local_user.image }),
      user: local_user.id,
      current_user: current_user.id
    }
  end
end
