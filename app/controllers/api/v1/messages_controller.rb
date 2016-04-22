class Api::V1::MessagesController < Api::V1::BaseController

	before_filter :find_channel, only: [:index]

	def index
		#@messages = policy_scope(Message.where(query_params))
		@messages = MessagePolicy::Scope.new(current_user, @channel, Message).resolve
		@messages = @messages.where(query_params)
			.order(id: :desc)
			.page(page_params[:page])
			.per(page_params[:page_size])
			.reverse()
	end
	
	def create
		@message = Message.new(message_params)
		@message.channel = Channel.find(params[:channel_id])
		@message.user = current_user
		@message.assets_ids = params[:assets_ids] if params[:assets_ids] 

		authorize @message

		if @message.save
			Pusher.trigger(@message.channel.project.channel, 'new_message', render_to_string(partial: 'api/v1/messages/message.json.jbuilder', :locals => {:message => @message}))
		else
			render json: @message.errors, status: :unprocessable_entity
		end
	end

	private
		def message_params
			params.require(:message).permit(:content, :channel_id, :user_id, assets_ids:[], assets_attributes:[:id])
		end

		def query_params
			# this assumes that an album belongs to an artist and has an :artist_id
      # allowing us to filter by this
			params.permit(:channel_id)
		end

	protected
		def find_channel 
  		if params[:channel_id]
     		@channel = Channel.find(params[:channel_id])
  		end
		end
end
