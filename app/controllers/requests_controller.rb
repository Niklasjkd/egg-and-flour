class RequestsController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @requests = Request.where(user_id: @user.id)
    @matches = @requests.map { |request| Request.where(recipe_id: request.recipe_id) }

    @markers = @matches[0].map do |m|
      {
        lat: User.find_by(id: m.user_id).latitude,
        lng: User.find_by(id: m.user_id).longitude
      }
    end
  end

  def create
    recipes = params[:requests][:recipes].scan(/\w+/)
    recipes.each do |recipe|
      new_request = Request.new(recipe_id: recipe, user_id: @user.id, host: false)
      new_request.save!
    end
    redirect_to recipe_requests_path(@user)
  end
end