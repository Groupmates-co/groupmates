class Api::V1::NotesController < Api::V1::BaseController

	after_action :verify_authorized, :except => [:index, :shared]

	def shared
		@notes = policy_scope(Note)
		@notes = @notes.where(permission: true)
		.page(page_params[:page])
		.per(page_params[:page_size])
		render :index
	end

  private
    def note_params
      params.require(:note).permit(:title, :content, :permission, :project_id, :user_id)
    end

    def query_params
    	{user_id: current_user.id}
    end
end
