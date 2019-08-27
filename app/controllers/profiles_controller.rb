class ProfilesController < ApplicationController
  def dashboard
    @user = current_user
  end
end
