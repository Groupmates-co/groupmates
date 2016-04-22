class Api::V1::PreferencesController < Api::V1::BaseController

  private
    def preference_params
      params.require(:preference).permit(:user_id, :project_id, :on_time, :from_time, :to_time)
    end

    def query_params
      params.permit(:project_id, :user_id)
    end
end