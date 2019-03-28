class FavoritesController < ApplicationController
    before_action :authenticate_user!
    def create
        @list = List.find(params[:list_id])
        if is_purchase?(current_user, @list)
            current_user.favorite(@list)
        end
    end
    
    def destroy
        @list = List.find(params[:list_id])
        if is_purchase?(current_user, @list)
            current_user.unfavorite(@list)
        end
    end
    
end
