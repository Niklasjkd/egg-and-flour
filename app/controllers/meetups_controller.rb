class MeetupsController < ApplicationController
  before_action :set_user, only: [:create, :show]
  def show
    @meetup = Meetup.find(params[:id])
  end

  def new
  end

  def create
    new_meetup = Meetup.new(host_id: current_user.id, guest_id: params[:request_id], status: "pending", recipes: params[:recipes].join)
    new_meetup.save!

    redirect_to request_path(id: params[:request_id], recipes: params[:recipes])
  end
end
