class Api::V1::BaseController < ActionController::Base
	include Pundit
	after_action :verify_authorized, :except => :index
	protect_from_forgery with: :null_session
	before_action :authenticate_user_from_token
	before_action :set_resource, only: [:destroy, :show, :update]
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
	respond_to :json

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	Pusher.app_id = Rails.configuration.x.pusher_app_id
	Pusher.key = Rails.configuration.x.pusher_api_key
	Pusher.secret = Rails.configuration.x.pusher_api_secret

	# POST /api/{plural_resource_name}
	def create
		set_resource(resource_class.new(resource_params))
		authorize get_resource
		if get_resource.save
			render :show, status: :created
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

	# DELETE /api/{plural_resource_name}/1
	def destroy
		authorize get_resource
		get_resource.destroy
		head :no_content
	end

	# GET /api/{plural_resource_name}
	def index
		plural_resource_name = "@#{resource_name.pluralize}"
		resources = policy_scope(resource_class)

		resources = resources.where(query_params)
		.page(page_params[:page])
		.per(page_params[:page_size])
		#authorize resource_class

		instance_variable_set(plural_resource_name, resources)
	end

	# GET /api/{plural_resource_name}/1
	def show
		authorize get_resource
		respond_with get_resource
	end

	# PATCH/PUT /api/{plural_resource_name}/1
	def update
		authorize get_resource
		if get_resource.update(resource_params)
			render :show
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

	protected
		# Authenticate User request
	  def authenticate_user_from_token
	    if params[:auth_token].present?
	      @user = User.find_by_authentication_token(params[:auth_token])
	      if @user 
	      	sign_in @user
	      else
	      	render json: {error: "Your authentication is invalid. Please sign out and retry."}, status: 401
	      end
	    else
	    	if user_signed_in?
	    		current_user
	    	else
	    		render json: {error: "You are not authenticated. Please sign in."}, status: 401
	    	end
	    end
	  end

		# Returns the resource from the created instance variable
		# @return [Object]
		def get_resource
			instance_variable_get("@#{resource_name}")
		end

		# Returns the allowed parameters for searching
		# Override this method in each API controller
		# to permit additional parameters to search on
		# @return [Hash]
		def query_params
			{}
		end

		# Returns the allowed parameters for pagination
		# @return [Hash]
		def page_params
			params.permit(:page, :page_size)
		end

		# The resource class based on the controller
		# @return [Class]
		def resource_class
			@resource_class ||= resource_name.classify.constantize
		end

		# The singular name for the resource class based on the controller
		# @return [String]
		def resource_name
			@resource_name ||= self.controller_name.singularize
		end

		# Only allow a trusted parameter "white list" through.
		# If a single resource is loaded for #create or #update,
		# then the controller for the resource must implement
		# the method "#{resource_name}_params" to limit permitted
		# parameters for the individual model.
		def resource_params
			@resource_params ||= self.send("#{resource_name}_params")
		end

		# Use callbacks to share common setup or constraints between actions.
		def set_resource(resource = nil)
			resource ||= resource_class.find(params[:id])
			# 	# if !current_user.projects.map(&:id).include?(params[:project_id].to_i)
			if params[:project_id]
				if resource.has_attribute?(:project_id)
					resource.project_id ||= params[:project_id]
				end
			end

			if resource.has_attribute?(:user_id) or params[:user_id] 
				resource.user_id ||= params[:user_id] ? params[:user_id] : current_user.id
			end
			
			instance_variable_set("@#{resource_name}", resource)
		end

		def user_not_authorized
			render json: {error: "You are not authorized to perform this action."}, status: 401
  	end
 
	  def cors_set_access_control_headers
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
	    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
	    headers['Access-Control-Max-Age'] = "1728000"
	  end
	 
	  def cors_preflight_check
	    if request.method == 'OPTIONS'
	      headers['Access-Control-Allow-Origin'] = '*'
	      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
	      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
	      headers['Access-Control-Max-Age'] = '1728000'
	 
	      render :text => '', :content_type => 'text/plain'
	    end
	  end

end
