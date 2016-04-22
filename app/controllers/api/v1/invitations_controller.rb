class Api::V1::InvitationsController < Api::V1::BaseController
	
	def create
		@invitation = Invitation.new(invitation_params.merge(
			{invited_by: current_user, project: Project.find(params[:project_id])})
		)
		authorize @invitation
		if @invitation.save
			AccountMailer.invitation_email(current_user, @invitation).deliver_now
			render :show, status: :created
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

	def update
		authorize get_resource
		if get_resource.update(resource_params)
			if get_resource.status == 4
				project = Project.find(get_resource.project.id)
				user = User.find_by(email: get_resource.invited_email)
				project.users << user
				# Pusher notify new_member
				userjson = render_to_string( partial: 'api/v1/users/user.json.jbuilder', :locals => {:user => user})
				Pusher.trigger(project.channel, 'new_member', userjson)
			end
			render :show
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

	private
		def invitation_params
			params.require(:invitation).permit(:invited_by_id, :project_id, :status, :invited_email)
		end

		def query_params
			params.permit(:project_id)
		end

end