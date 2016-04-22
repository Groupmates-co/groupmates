class Api::V1::AssetMessagesController < Api::V1::BaseController

	skip_before_filter :set_resource, :only => :destroy

	def create
		set_resource(resource_class.new(resource_params))
		if get_resource.save
			render json: nil, status: :created
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

  private
    def assignation_params
      params.require(:asset_message).permit(:asset_id, :message_id)
    end

end