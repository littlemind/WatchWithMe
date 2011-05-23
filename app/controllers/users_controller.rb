class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:id])
    @reservations = @user.participated_reservations
    @upcoming_reservations = @reservations.where("screening > ?", Time.now)
    @recent_reservations = @reservations.where("screening < ?", Time.now)
  end
    
end
