class UsersController < ApplicationController

  def gym_buddy
    # view is used to gather search params for user#index
  end

  def index

    # check if location param is passed, then calcualte lon and lat for the location
    if params[:search] && params[:search] != ""
      radius = params[:radius];
      search_location_lat = Geocoder.search(params[:search])[0].data["lat"]
      search_location_lon = Geocoder.search(params[:search])[0].data["lon"]
    end


    # check if location, activity goal and fitness level params are passed
    if params[:search] && params[:search] != "" && params[:activity_goal] != "" && params[:fitness_level] != 'ALL'
      search_users = User.near([search_location_lat, search_location_lon], radius, units: :km).where(fitness_level: params[:fitness_level]).where(activity_goal: params[:activity_goal])

    # check if locartion and activity level params are passed
    elsif params[:search] && params[:search] != "" && params[:activity_goal] != ""
      search_users = User.near([search_location_lat, search_location_lon], radius, units: :km).where(activity_goal: params[:activity_goal])

    # check if location and fitness level params are passed
    elsif params[:search] && params[:search] != "" && params[:fitness_level] != 'ALL'
      search_users = User.near([search_location_lat, search_location_lon], radius, units: :km).where(fitness_level: params[:fitness_level])

    # check if activity goal and fitness level are passed
    elsif params[:activity_goal] != "" && params[:fitness_level] != 'ALL'
      search_users = User.where(activity_goal: params[:activity_goal]).where(fitness_level: params[:fitness_level])

    # check if location param is passed
    elsif params[:search] && params[:search] != ""
      search_users = User.near([search_location_lat, search_location_lon], radius, units: :km)

    # check if activity param is passed
    elsif params[:activity_goal] != ""
      search_users = User.where(activity_goal: params[:activity_goal])

    # check if fitness level param is passed
    elsif params[:fitness_level] != 'ALL'
      search_users = User.where(fitness_level: params[:fitness_level])

    # check if all params are left blank
    else
      search_users = User.all
    end

    # iterate through search_users and check if they have a public profile
    available_users = []
    search_users.each do |user|
      if user.matching
        available_users << user
      end
    end
    @users = available_users

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

end
