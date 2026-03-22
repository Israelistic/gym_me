class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def gym_buddy; end

  def index
    @users = User.where(matching: true)

    if params[:search].present?
      result = Geocoder.search(params[:search]).first
      if result
        coords = [result.data["lat"], result.data["lon"]]
        @users = User.near(coords, params[:radius], units: :km).where(matching: true)
      end
    end

    filtering_params(params).each do |key, value|
      @users = @users.public_send(key, value) if value.present?
    end

    if params[:availability_check].present? && current_user.availability.present?
      @users = @users.select { |user| (user.availability & current_user.availability).any? }
    end
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @events = @user.events
    @owned_events = @user.owned_events
  end

  def home
    unless current_user
      redirect_to new_user_session_path
      return
    end

    @user = current_user
    @events = @user.events
    @owned_events = @user.owned_events
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      @user.avatar.attach(params[:user][:avatar]) if params.dig(:user, :avatar).present?
      redirect_to user_path(@user.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :age, :gender, :activity_goal,
      :fitness_level, :location, :description, :matching,
      availability: []
    )
  end

  def filtering_params(params)
    params.slice(:activity_goal, :fitness_level, :gender)
  end
end
