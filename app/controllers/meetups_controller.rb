class MeetupsController < ApplicationController
  before_action :set_user, only: [:create, :show]
  def show
    @meetup = Meetup.find(params[:id])
  end

  def new
  end

  def create
    raise
    requests = params[:meetups][:requests], params[:meetups][:recipes]
    requests.each do |request, recipe|
      new_meetup = Meetup.new(host_id: request, guest_id: request, recipe_id: recipe)
      new_meetup.save!
      raise
    end
    redirect_to recipe_request_meetup_path(params[:recipe_id], request, @user)
  end
end
