class FavoritesController < ApplicationController
    before_action :authenticate_user!
    def create
        @list = List.find(params[:list_id])
        current_user.favorite(@list)
    end
    
    def destroy
        @list = List.find(params[:list_id])
        current_user.unfavorite(@list)
    end
end
