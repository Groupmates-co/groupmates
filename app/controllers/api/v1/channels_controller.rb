class Api::V1::ChannelsController < Api::V1::BaseController

	after_action :new_channel_open, :only => :create

  private

  	def new_channel_open
  		Pusher.trigger(@channel.project.channel, 'new_channel_open', render_to_string(partial: 'api/v1/channels/channel.json.jbuilder', :locals => {:channel => @channel}))
  	end

    def channel_params
      params.require(:channel).permit(:project_id, :name, :is_private, user_ids:[], users_attributes:[:id])
    end

    def query_params
      params.permit(:name, :project_id, :is_private)
    end

end