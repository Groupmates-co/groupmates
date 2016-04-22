class Api::V1::AssignationsController < Api::V1::BaseController
	skip_before_filter :set_resource

  def update
  	assignment = Assignation.find(query_params)
		authorize assignment
		assignment.update(assignment_params)

		project = Project.find(current_user.last_project_opened)
    userjson = render_to_string( partial: 'api/v1/users/user.json.jbuilder', locals: { user: current_user })
    Pusher.trigger(project.channel, 'updated_member', userjson)

  	render json: []
  end

  private
    def assignment_params
      params.permit(:project_id, :user_id, :role)
    end

    def query_params
      [current_user.id, params[:project_id]]
    end
end