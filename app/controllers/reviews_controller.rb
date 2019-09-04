class ReviewsController < ApplicationController

  def new
    @review = Review.new()
  end

  def create
    @review = Review.new(review_params)
    @review.save!
    redirect_to dashboard_profile_path(current_user)
  end

  private

  def review_params
    params[:review].permit(:meetup_id, :user_id, :content, :rating)
  end
end
