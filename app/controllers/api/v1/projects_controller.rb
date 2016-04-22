class Api::V1::ProjectsController < Api::V1::BaseController
	
	after_action :verify_policy_scoped, :only => :index
	
  private
    def project_params
      params.require(:project).permit(:name, :duration, :creator, :users, users_attributes: [:id])
    end

    def query_params
      params.permit(:name)
    end

end
