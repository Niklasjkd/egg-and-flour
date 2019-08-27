class RequestsController < ApplicationController
  def index
    requests = Request.where(email: @user.email)
    matches = []
    request.each do |request|
     matches << Request.where(recipe_id: request.recipe_id)
  end
end
