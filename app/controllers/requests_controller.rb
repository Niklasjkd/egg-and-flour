class RequestsController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @requests = Request.where(user_id: @user.id)
    @matches = @requests.map { |request| Request.where(recipe_id: request.recipe_id) }

    @matches[0].each do |m|
      @markers = [{
        lat: User.find_by(id: m.user_id).lat,
        lng: User.find_by(id: m.user_id).lng
      }]
    end
  end
end
