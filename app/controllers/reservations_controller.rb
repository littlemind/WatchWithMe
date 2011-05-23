class ReservationsController < ApplicationController
  before_filter :find_user
  
  def show
    @reservation = Reservation.find(params[:id])
    @movie = @reservation.movie
    @tickets = @reservation.tickets
    @organizer = @reservation.organizer
  end

  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = @user.organized_reservations.new
  end
  
  def create
    ticket_count = params[:ticket_count].to_i
    @reservation = @user.organized_reservations.new(params[:reservation])
    if @reservation.save  
      ticket_count.times { @reservation.tickets.create }
      redirect_to([@user,@reservation], :notice => "Reservations successfully created.")
    else
      render :action => :new
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(params[:reservation])
      flash[:notice] = "Successfully updated exercise."
      redirect_to @exercise
    else
      render :action => 'edit'
    end
  end

  def destroy
  end
  
  def find_user
    if params[:user_id]
      @user = User.find_by_username(params[:user_id])
    else
      @user = current_user
    end
  end

end
