class Api::V1::ChannelUsersController < Api::V1::BaseController

	before_action :set_resource, only: [:show, :update]

	def create
		set_resource(resource_class.new(resource_params))
		authorize get_resource
		if get_resource.save
			render json: nil, status: :created
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

	def destroy
		channel = Channel.find(params[:channel_id])
		user = User.find(params[:id])
		authorize channel
		if channel
			if channel.users.delete(user)
				if (channel.users.empty?)
					channel.destroy
				else
					channel.save
				end
				render json: nil, root: false, status: 204
			else
				render json: user.errors, status: :unprocessable_entity
			end
		else
			render json: nil, status: 404
		end
	end

  private
    def channel_user_params
      params.require(:channel_user).permit(:user_id, :channel_id)
    end

    def query_params
      params.permit(:channel_id, :user_id)
    end

end