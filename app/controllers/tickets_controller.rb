class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    if @event.capacity <= 0
      redirect_to event_path(@event), alert: "This event is full."
      return
    end

    if Ticket.exists?(user: current_user, event: @event)
      redirect_to event_path(@event), alert: "You have already joined this event."
      return
    end

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
    @ticket = Ticket.find_by(user: current_user, event: @event)

    unless @ticket
      redirect_to event_path(@event), alert: "Ticket not found."
      return
    end

    @ticket.destroy
    @event.increment!(:capacity)
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
