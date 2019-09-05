class ReviewsController < ApplicationController

  def new
    @review = Review.new()
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to dashboard_profile_path(current_user)
    else
      render :new
    end
  end

  private

  def review_params
    params[:review].permit(:meetup_id, :user_id, :content, :rating, :for_user_id)
  end
end
