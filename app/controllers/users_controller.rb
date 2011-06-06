class UsersController < ApplicationController
  def show
    @user = User.find_user_by_url(params[:id])
#    @reservations = Reservation.all(:joins => {:participants => :tickets}, :conditions => {:tickets => {:participant_id => @user.id}},:conditions => {:organizer_id => @user.id})
    @reservations = @user.participated_reservations
    @upcoming_reservations = @reservations.upcoming.limit(3)
    @recent_reservations = @reservations.recent(2.week.ago).order("reserved_at DESC").limit(3)
  end
    
end
