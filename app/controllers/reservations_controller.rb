class ReservationsController < ApplicationController
  before_filter :find_user, :only => [:show]
  before_filter :authenticate_user!, :except => [:show]
  
  def show
    @reservation = Reservation.find(params[:id], :include => [:participants, :organizer,:movie])
    if @reservation.visible_for_user?(current_user)
      @tickets = @reservation.tickets
      @organizer = @reservation.organizer
    else
      redirect_to @user
    end
    
    
  end

  def index
    if user_signed_in?
      @participated_reservations = current_user.participated_reservations.all(:joins => [:tickets,:movie], :select => ["reservations.*, count(DISTINCT tickets.id) as tickets_count","reservations.*, movies.title as movie_title"],:group => "reservations.id")
      @organized_reservations = current_user.organized_reservations.all(:joins => [:tickets,:movie], :select => ["reservations.*, count(DISTINCT tickets.id) as tickets_count","reservations.*, movies.title as movie_title"],:group => "reservations.id")
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @reservation = current_user.organized_reservations.new
    @reservation.visible_for_public = true
  end
  
  def create
    ticket_count = params[:ticket_count].to_i
    @reservation = current_user.organized_reservations.new(params[:reservation])
    if @reservation.save  
      ticket_count.times { @reservation.tickets.create }
      redirect_to([current_user,@reservation], :notice => "Reservations successfully created.")
    else
      render :action => :new
    end
  end

  def edit
    @reservation = current_user.organized_reservations.find(params[:id])
  end
  
  def update
    @reservation = current_user.organized_reservations.find(params[:id])
    if @reservation.update_attributes(params[:reservation])
      flash[:notice] = "Successfully updated exercise."
       redirect_to([current_user,@reservation], :notice => "Reservations successfully changed.")
    else
      render :action => 'edit'
    end
  end

  def destroy
  end
  
  private
  
  def find_user
    @user = User.find_user_by_url(params[:user_id])
  end

end
