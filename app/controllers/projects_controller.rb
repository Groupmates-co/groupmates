class ProjectsController < ApplicationController
	
	Pusher.app_id = Rails.configuration.x.pusher_app_id
	Pusher.key = Rails.configuration.x.pusher_api_key
	Pusher.secret = Rails.configuration.x.pusher_api_secret

	before_filter :authenticate_user!
	before_action :project_restrict, only: [:create, :new]

	layout "user"

	def index
		@projects = current_user.projects
		@invitations = Invitation.where("invited_email = ? AND status != ?",
			current_user.email, Invitation::COMPLETED).order(:invited_by_id)
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		@project.creator = current_user

		if @project.save
			current_user.projects << @project
			current_user.last_project_opened = @project

			@channel = Channel.new

			@channel.set_main_channel(@project, current_user)
			@channel.save

			Message.new.set_welcome_message(@channel)
			params['member'].each do |key,email|
				if !email.blank?
					user = User.find_by(:email => email)
					if !user # User doesn't exist
						invitation = Invitation.create(
							invited_by: current_user, 
							project: @project, 
							status: Invitation::APPROVED_NOT_JOINED, 
							invited_email: email)
						invitation.save

						#Send email
						AccountMailer.invitation_email(current_user,invitation).deliver_now

					else #User is already registered 

						# Pusher notify new_member
						@userjson = render_to_string( partial: 'api/v1/users/user.json.jbuilder', :locals => {:user => user})
						Pusher.trigger(@project.channel, 'new_member', @userjson)

					end
				end
			end

			ProjectFs::create_project_folder(@project)

			redirect_to project_path(@project)
		else
			render 'new'
		end
	end

	def join
		@invitation = Invitation.where(invited_email: current_user.email, project_id: params[:project_id]).take
		
		# When user has been invited and didn't join
		if @invitation.status == Invitation::NOT_APPROVED_NOT_JOINED
			@invitation.update(status: Invitation::NOT_APPROVED_JOINED) 
			redirect_to projects_path

		# When user has been invited by admin or approved alread but didn't join
		elsif @invitation.status == Invitation::APPROVED_NOT_JOINED
			@invitation.update(status: Invitation::COMPLETED)
			@invitation.project.users << current_user
			@invitation.project.channels.first.users << current_user

			# Pusher notify new_member
			@userjson = render_to_string( partial: 'api/v1/users/user.json.jbuilder', :locals => {:user => current_user})
			Pusher.trigger(@invitation.project.channel, 'new_member', @userjson)
			# Redirect to the project, doesn't work :(
			redirect_to p_path(@invitation.project.slug)
		else
			redirect_to projects_path
		end
	end

	def dashboard
		@project = current_user.projects.find_by(slug: params[:slug])
		render "show", layout: "groupmates"
	end

	def show
		@project = current_user.projects.find(params[:id])
		redirect_to p_path(@project.slug)
	end

	def checkname
		project = Project.where(name: params[:name])
		@exists = (project == [])
		render json: @exists
	end

	private

	# Allowed params for project
	def project_params
		params.require(:project).permit(:name, :description, :duration)
	end

	# Restrict users to have only two project in the same time
	def project_restrict
		max_projects = 10
		allowed = false
		if user_signed_in?
			if !(current_user.projects.length < max_projects)
				#set flash here
				flash[:warning] = "Only #{max_projects} projects per user at the moment, we are working hard to remove that restriction! ;)"
				redirect_to :action => 'index', :controller => 'projects'
			end
		end
	end
end
