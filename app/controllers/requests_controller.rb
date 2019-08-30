class RequestsController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @requests = Request.where(user_id: @user.id)
    @matches = []
    @requests.each do |request|
      params[:selected_recipes].each do |selected_recipe|
        requests = Request.find_by(recipe_id: selected_recipe.to_i)
        @matches << requests if requests[:user_id] != @user.id
      end
    end

    @markers = @matches.map do |m|
      {
        lat: User.find_by(id: m.user_id).latitude,
        lng: User.find_by(id: m.user_id).longitude
      }
    end
    @markers << {
        lat: User.find_by(id: @user.id).latitude,
        lng: User.find_by(id: @user.id).longitude
      }
  end
end
