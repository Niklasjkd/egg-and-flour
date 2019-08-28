class RequestsController < ApplicationController
  before_action :set_user, only: [:index]

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
end
