class RequestsController < ApplicationController
  before_action :set_user, only: [:index, :create, :show]

  def index
    @requests = Request.where(user_id: @user.id)
    @matches = []
    @requests.each do |request|
      requests = Request.where(recipe_id: request.recipe_id)
      requests.each do |match|
        @matches << match if match[:user_id] != @user.id
      end
    end

    @markers = @matches.map do |m|
      user = User.find_by(id: m.user_id)
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window_map", locals: { name: user.first_name + " " + user.last_name, place_type: "Meetup" })
      }
    end

    local_user = User.find_by(id: @user.id)
    @markers << {
      lat: local_user.latitude,
      lng: local_user.longitude,
      infoWindow: render_to_string(partial: "info_window_map", locals: { name: "You", place_type: "This is your location!" })
    }
  end



  def create
    recipes = params[:requests][:recipes].scan(/\w+/)
    recipes.each do |recipe|
      new_request = Request.new(recipe_id: recipe, user_id: @user.id, host: true)
      new_request.save!
    end
    redirect_to recipe_requests_path(@user)
  end

  def show
    @request = Request.find(params[:id])
    @requests = Request.where(user_id: @user.id)
    @matches = []
    @requests.each do |request|
      requests = Request.where(recipe_id: request.recipe_id)
      requests.each do |match|
        @matches << match if match[:user_id] != @user.id
      end
    end
  end
end
