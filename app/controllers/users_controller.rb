class UsersController < ApplicationController
  def show
    @user = User.find_user_by_url(params[:id])
#    @reservations = Reservation.all(:joins => {:participants => :tickets}, :conditions => {:tickets => {:participant_id => @user.id}},:conditions => {:organizer_id => @user.id})
    @reservations = @user.participated_reservations
    @upcoming_reservations = @reservations.where("screening > ?", Time.now)
    @recent_reservations = @reservations.where("screening < ?", Time.now)
  end
    
end
