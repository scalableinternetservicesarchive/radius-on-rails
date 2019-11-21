class RelationshipsController < ApplicationController
    before_action :authenticate_user!

    def create
        user = User.find(params[:followed_id])
        current_user.follow(user)
        respond_to do |format|
            format.html { redirect_to user, notice: 'User was successfully followed.' }
            format.json
        end
    end
    
    def destroy
        user = Relationship.find(params[:id]).followed
        current_user.unfollow(user)
        respond_to do |format|
            format.html { redirect_to user, alert: 'User was unfollowed.' }
            format.json
        end
    end
end
