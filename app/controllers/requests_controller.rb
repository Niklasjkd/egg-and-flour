class RequestsController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @requests = Request.where(user_id: @user.id)
    @matches = @requests.map { |request| Request.where(recipe_id: request.recipe_id) }
  end
end
