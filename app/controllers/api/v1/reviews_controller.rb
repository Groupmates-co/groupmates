class Api::V1::ReviewsController < Api::V1::BaseController

	def create
		set_resource(resource_class.new(resource_params))
		authorize get_resource
		if get_resource.save
			ReviewMailer.review_email(current_user,@review).deliver_now
			render :show, status: :created
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

  private
    def review_params
      params.require(:review).permit(:rating, :feedback, :user_id)
    end
end
