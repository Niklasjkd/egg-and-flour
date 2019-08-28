class MeetupsController < ApplicationController
  def show
    @meetup = Meetup.find(params[:id])
  end
end
