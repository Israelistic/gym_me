class TicketsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @ticket = Ticket.new(user: current_user, event: @event)

    if @ticket.save
      @event.decrement!(:capacity)
      redirect_to event_path(@event)
    else
      flash[:alert] = "Something went wrong"
      redirect_to event_path(@event)
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @ticket = Ticket.find_by!(user: current_user, event: @event)
    @ticket.destroy
    @event.increment!(:capacity)
    redirect_to event_path(@event)
  end
end
