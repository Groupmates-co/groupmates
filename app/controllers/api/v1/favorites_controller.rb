class Api::V1::FavoritesController < Api::V1::BaseController

  private
    def favorite_params
      params.require(:favorite).permit(:user_id, :message_id, :content, :project_id)
    end

    def query_params
    	params.permit(:user_id, :message_id, :project_id)
    end
end
