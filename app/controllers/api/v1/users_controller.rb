class Api::V1::UsersController < Api::V1::BaseController

  def updateproject
    authorize current_user
    current_user.last_project_opened = params[:project_id]
    current_user.last_project_quit = Time.now
    current_user.save
    render json: {}, status: 200 
  end

	def current
    @user = current_user
    authorize @user
    render json: render_to_string(template: 'api/v1/users/current.json.jbuilder', locals: {user: @user})
	end

  def update
    authorize @user
    if @user.update(user_params)
      project = Project.find(@user.last_project_opened)
      userjson = render_to_string( partial: 'api/v1/users/user.json.jbuilder', :locals => {:user => @user})
      Pusher.trigger(project.channel, 'updated_member', userjson)
      render json: {}, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :skype, :bio, :last_project_quit, :last_project_opened, project_attributes: [:id, :name, :duration])
    end

    def query_params
      params.permit(:email)
    end
end
