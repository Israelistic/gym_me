class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :discover]
  before_action :set_event, only: [:show, :edit, :update]
  before_action :authorize_owner!, only: [:edit, :update]

  ACTIVITY_ICONS = {
    "Yoga/Pilates" => "lotus-position.svg",
    "Resistence Training" => "dumbbell.svg",
    "Cardio" => "athletics.svg",
    "Recreation" => "american-football.svg"
  }.freeze

  def discover; end

  def index
    @events = if params[:search].present?
                search_events_by_location
              else
                Event.all
              end
  end

  def show
    @comments = @event.comments
    @comment = Comment.new
    @users = @event.users
    @ticket = Ticket.find_by(user_id: current_user.id, event_id: @event.id) if current_user
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.activity_icon = ACTIVITY_ICONS.fetch(@event.activity_type, "american-football.svg")

    if @event.save
      redirect_to root_url
    else
      flash.now[:alert] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Something went wrong"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_owner!
    unless @event.user_id == current_user.id
      redirect_to events_path, alert: "You are not authorized to modify this event."
    end
  end

  def event_params
    params.require(:event).permit(
      :title, :address, :time, :end_date, :persistence,
      :description, :activity_type, :capacity, :need_approval
    )
  end

  def search_events_by_location
    result = Geocoder.search(params[:search]).first
    return Event.none unless result

    coords = [result.data["lat"], result.data["lon"]]
    scope = Event.near(coords, 20, units: :km)
    scope = scope.where(activity_type: params[:activity_type]) if params[:activity_type].present?
    scope
  end
end
