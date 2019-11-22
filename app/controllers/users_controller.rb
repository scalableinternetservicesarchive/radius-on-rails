class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /users
  # GET /users.json
  def index
    @users = User.within(700, :origin => [current_user.lat,current_user.lng]).where.not(id: current_user.id)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to user_path(current_user.id) unless params[:id]
    @user = User.find(params[:id]) if params[:id]
  end

  # PATCH/PUT /users/1/update_location
  # PATCH/PUT /users/1.json/update_location
  def update_location
    respond_to do |format|
      unless cookies[:lat_lng].nil?
        lat, lng = cookies[:lat_lng].split("|")

        if params[:id].to_i == current_user.id && helpers.is_valid_coord?(lat) && helpers.is_valid_coord?(lng)
          current_user.update(:lat => lat.to_f, :lng => lng.to_f)
          format.html { redirect_to root_path, notice: 'Location was successfully updated.' }
          format.json { render :show, status: :ok, location: root_path }
        else
          format.html { redirect_to root_path, alert: 'Location could not be updated.' }
          format.json { render json: current_user.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to root_path, alert: 'Sorry, your browser does not support HTML5 geolocation.' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /feed
  def feed
    @posts = current_user.feed.includes(:user)
    @post = Post.new
  end

  def following
    # For now, restrict user to only be able to see their own following
    if Float(params[:id]) == current_user.id
      @title = "Following"
      @user  = current_user
      @users = @user.following
      render 'show_follow'
    else
      redirect_to following_user_path(current_user.id)
    end
  end

  def followers
    # For now, restrict user to only be able to see their own followers
    if Float(params[:id]) == current_user.id
      @title = "Followers"
      @user  = current_user
      @users = @user.followers
      render 'show_follow'
    else
      redirect_to followers_user_path(current_user.id)
    end
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_user
  #     @user = User.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def user_params
  #     params.require(:user).permit(:name, :bio)
  #   end
end
