class UsersController < ApplicationController
  def show
    @user = User.find_user_by_url(params[:id])
    @reservations = @user.participated_reservations
    @upcoming_reservations = @reservations.upcoming.limit(3)
    @recent_reservations = @reservations.recent(2.week.ago).order("reserved_at DESC").limit(3)

  end
    
end
