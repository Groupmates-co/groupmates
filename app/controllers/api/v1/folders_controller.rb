class Api::V1::FoldersController < Api::V1::BaseController

  private
    def folder_params
      params.require(:folder).permit(:name, :user_id, :project_id, :parent_id)
    end

	def query_params
		params.permit(:project_id)
	end

end
