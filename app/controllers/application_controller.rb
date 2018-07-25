class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
# allow the passing of the strong params (first_name, sex, etc) in devise
 # along with other params into account_update
  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :location, :fitness_level, :sex, :description, address: [:street_address, :city, :state, :zip]])
  end


helper_method :joined_event?

private

def joined_event?
  current_event = Event.find(params[:id])
  current_user && current_event.users.find_by(id: current_user.id)

end

end
