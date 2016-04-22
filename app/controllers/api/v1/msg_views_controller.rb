class Api::V1::MsgViewsController < Api::V1::BaseController

	skip_before_action :set_resource

	def index
		@msg_views = MsgViewPolicy::Scope.new(current_user, Channel.find(params[:channel_id]), MsgView).resolve
		@msg_views = @msg_views.where(query_params)
			.page(page_params[:page])
			.per(page_params[:page_size])
	end

	def view
		@msg_view = MsgView.find_or_create_by(msg_view_params) #MsgView.first_or_create(msg_view_params)
		authorize @msg_view
		# Set the last message
		@msg_view.message = Message.where(channel: params[:msg_view][:channel_id]).last()

		if @msg_view.update(msg_view_params)
			Pusher.trigger(@msg_view.channel.project.channel, 'member_read_message', render_to_string(template: 'api/v1/msg_views/show.json.jbuilder', :locals => {:msg_view => @msg_view}))
			render :show
		else
			render json: msg_view.errors, status: :unprocessable_entity
		end
	end


  private
    def msg_view_params
      params.require(:msg_view).permit(:user_id, :message_id, :channel_id)
    end

    def query_params
    	params.permit(:message_id,:channel_id,:user_id)
    end

end