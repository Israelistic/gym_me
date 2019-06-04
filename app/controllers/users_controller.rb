class UsersController < ApplicationController

  def gym_buddy
    # view is used to gather search params for user#index
  end

  def index

    @users = User.all
    # check if location param is passed, then calcualte lon and lat for the location
    if params[:search].present?
      radius = params[:radius];
      search_location_lat = Geocoder.search(params[:search])[0].data["lat"]
      search_location_lon = Geocoder.search(params[:search])[0].data["lon"]
      @users = User.near([search_location_lat, search_location_lon], radius, units: :km)
    end
    @users = @users.where(matching: true)


    filtering_params(params).each do |key, value|
      @users = @users.public_send(key, value) if value.present?
    end

    # Above makes use of filtering_params private method and public_send ruby method to reduce the following redundant code.
    # Also, if more search params are added, they are automatically accounted for.
    # @users = @users.activity_goal(params[:activity_goal]) if params[:activity_goal].present?
    # @users = @users.fitness_level(params[:fitness_level]) if params[:fitness_level].present?
    # @users = @users.gender(params[:gender]) if params[:gender].present?

  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
      @events = @user.events
      @owned_events = @user.owned_events
  end

  def home
    if current_user
      @user = current_user
      @events = @user.events
      @owned_events = @user.owned_events
    else
      redirect_to "devise/sessions#new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.age = params[:user][:age]
    @user.gender = params[:user][:gender]
    @user.activity_goal = params[:user][:activity_goal]
    @user.fitness_level = params[:user][:fitness_level]
    @user.location = params[:user][:location]
    @user.description = params[:user][:description]
    @user.matching = params[:user][:matching]
    @user.day= params[:user][:day]
    @user.time_of_day= params[:user][:time_of_day]

    unless params[:user][:avatar] == nil
      @user.avatar.attach(params[:user][:avatar])
    end


    if @user.save
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  # Params that can be used to filter search results
  def filtering_params(params)
    params.slice(:activity_goal, :fitness_level, :gender)
  end

end
