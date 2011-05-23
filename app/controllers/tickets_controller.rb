class TicketsController < ApplicationController
  def update
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.update_attribute(:participant_id, current_user.id)
    redirect_to :root
  end
  
  def create
    
  end

  def destroy
    
  end
  
end
