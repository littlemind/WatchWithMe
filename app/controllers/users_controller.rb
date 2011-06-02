class UsersController < ApplicationController
  def show
    @user = User.find_user_by_url(params[:id])
#    @reservations = Reservation.all(:joins => {:participants => :tickets}, :conditions => {:tickets => {:participant_id => @user.id}},:conditions => {:organizer_id => @user.id})
    @reservations = @user.reservations.visible
    @upcoming_reservations = @reservations.upcoming
    @recent_reservations = @reservations.recent(2.week.ago).order("reserved_at DESC")
  end
    
end
