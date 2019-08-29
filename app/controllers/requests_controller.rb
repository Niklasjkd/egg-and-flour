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



  def create
    recipes = params[:requests][:recipes].scan(/\w+/)
    recipes.each do |recipe|
      new_request = Request.new(recipe_id: recipe, user_id: @user.id, host: false)
      new_request.save!
    end
    redirect_to recipe_requests_path(@user)
  end

  def show
    @request = Request.find(params[:id])
  end
end
