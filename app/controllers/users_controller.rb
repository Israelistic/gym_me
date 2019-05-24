class UsersController < ApplicationController

  def gym_buddy
    # view is used to gather search params for user#index
  end

  def index
    raise
    # # check for search parameters
    # if params[:search] && params[:activity_type]
    # check if search parameter is being passed and isnt an empty string
    if params[:search] && !params[:search].empty?
      # radius = 20;
      # search_location_lat = Geocoder.search(params[:search])[0].data["lat"]
      # search_location_lon = Geocoder.search(params[:search])[0].data["lon"]
      if params[:activity_goal] == ""
        # google maps API for search radius
        search_users = User.where(fitness_level: params[:fitness_level])
      else
        search_users = User.where(activity_goal: params[:activity_goal]).where(fitness_level: params[:fitness_level])
      end
      # iterate through the events and check if the there are spots available (capacity > 0)
      # and that the event has not started
      # available_events = []
      # search_events.each do |event|
      #   # if event.capacity && event.time
      #   #   if event.capacity > 0 && event.time > Time.now
      #       available_events << event
      #   #   end
      #   # end
      # end
      # @events = available_events
      @users = search_users
    else
      all_users = User.all
      available_users = []

      all_users.each do |user|
        if user.matching == true
          available_users << user
        end
      end
      @users = available_users
    end






    # check if search parameter is being passed and isnt an empty string
    if params[:search] && !params[:search].empty?
      # radius = 20;
      # search_location_lat = Geocoder.search(params[:search])[0].data["lat"]
      # search_location_lon = Geocoder.search(params[:search])[0].data["lon"]

      search_users = User.basic_search(params[:search])
      # iterate through the users and check if the they are looking for gym buddy (ie. user.matching == true)
      available_users = []
      search_users.each do |user|
        if user.matching == true
          available_users << user
        end
      end
      @users = available_users

    else
      all_users = User.all
      available_users = []

      all_users.each do |user|
        if user.matching == true
          available_users << user
        end
      end
      @users = available_users
    end

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
