class TicketsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.update_attribute(:participant_id, current_user.id)
    redirect_to [@ticket.reservation.organizer,@ticket.reservation]
  end

  def destroy
    @ticket = current_user.tickets.find(params[:id])
    @ticket.update_attribute(:participant_id, nil)
    
    redirect_to([@ticket.reservation.organizer,@ticket.reservation])
  end
  
end
