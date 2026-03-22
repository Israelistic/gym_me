class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :location, :fitness_level, :sex,
      :description, :street_address, :city, :province, :postal_code, :country
    ])
  end

  helper_method :joined_event?, :user_avatar, :event_activity_icon, :availability_match?

  private

  def joined_event?
    current_event = Event.find(params[:id])
    current_user && current_event.users.exists?(id: current_user.id)
  end

  def user_avatar(user)
    case user.gender
    when "Male" then "jimmy.png"
    when "Female" then "yanny.svg"
    else "blank-avatar.svg"
    end
  end

  def event_activity_icon(event)
    case event.activity_type
    when "Yoga/Pilates" then "lotus-position.svg"
    when "Resistence Training" then "dumbbell.svg"
    when "Cardio" then "athletics.svg"
    when "Recreation" then "american-football.svg"
    else "gym.svg"
    end
  end

  def availability_match?(user, day)
    if user.availability.include?(day) && current_user.availability.include?(day)
      "scheduleSquare scheduleSquareAvailableMatch"
    elsif user.availability.include?(day)
      "scheduleSquare scheduleSquareAvailable"
    else
      "scheduleSquare"
    end
  end
end
