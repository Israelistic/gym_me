class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # allow the passing of the strong params (first_name, sex, etc) in devise
  # along with other params into account_update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :location, :fitness_level, :sex, :description, :street_address, :city, :province, :postal_code, :country])
  end

  def online_status(user)
  content_tag :span, user.name, class: "user-#{user.id} online_status #{'online' if user.online?}"
end

def emojify(content)
h(content).to_str.gsub(/:([\w+-]+):/) do |match|
  if emoji = Emoji.find_by_alias($1)
    %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
  else
    match
  end
end.html_safe if content.present?
end

  helper_method :joined_event?
  helper_method :user_avatar
  helper_method :event_activity_icon
  helper_method :availabilityMatch?


  private

  # returns truthy value if current_user has joined an event
  def joined_event?
    current_event = Event.find(params[:id])
    current_user && current_event.users.find_by(id: current_user.id)
  end

  # give user avatar based on gender
  def user_avatar(user)
    if user.gender == "Male"
      return "jimmy.png"
    elsif user.gender == "Female"
      return "yanny.svg"
    else
      return "blank-avatar.svg"
    end
  end

  # gives event icon based on activity_type
  def event_activity_icon(event)
    if event.activity_type == "Yoga/Pilates"
      return "lotus-position.svg"
    elsif event.activity_type == "Resistence Training"
      return "dumbbell.svg"
    elsif event.activity_type == "Cardio"
      return "athletics.svg"
    elsif event.activity_type == "Recreation"
      return "american-football.svg"
    else
      return "gym.svg"
    end
  end

  def availabilityMatch?(user, day)
    if user.availability.include?(day) && current_user.availability.include?(day)
      return "scheduleSquare scheduleSquareAvailableMatch"
    elsif user.availability.include?(day)
      return "scheduleSquare scheduleSquareAvailable"
    else
      return "scheduleSquare"
    end
  end


end
