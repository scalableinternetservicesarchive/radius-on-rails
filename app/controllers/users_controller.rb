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
    # user = User.find(params[:id])
    # @nearby_users = User.within(700, :origin => [user.lat,user.lng]).where.not(id: user.id)
  end

  # PATCH/PUT /users/1/update_location
  # PATCH/PUT /users/1.json/update_location
  def update_location
    lat, lng = cookies[:lat_lng].split("|")

    respond_to do |format|
      if params[:id].to_i == current_user.id && helpers.is_valid_coord?(lat) && helpers.is_valid_coord?(lng)
        current_user.update(:lat => lat.to_f, :lng => lng.to_f)
        format.html { redirect_to root_path, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { redirect_to root_path, notice: 'Location could not be updated.' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /feed
  def feed
    # redirect_to feed_path(current_user.id) unless Float(params[:id]) == current_user.id
    @posts = current_user.feed
    @post = Post.new
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
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
