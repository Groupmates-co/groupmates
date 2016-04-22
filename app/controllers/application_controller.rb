class ApplicationController < ActionController::Base

	include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :ref_to_cookie

	def after_sign_in_path_for(resource)
		if resource.projects.count == 1
			project_path(resource.projects.first)
		elsif resource.projects.count == 0
			new_project_path
		else
			projects_path
		end
	end

	def configure_permitted_parameters
		# Override accepted parameters
		devise_parameter_sanitizer.for(:accept_invitation) do |u|
			u.permit(:first_name, :last_name, :email, :password, :password_confirmation,
			:invitation_token)
		end
	end

  def ref_to_cookie
		if params[:ref]
			if !Subscription.find_by(referral_code: params[:ref]).nil?
				cookies[:h_ref] = { :value => params[:ref], :expires => 1.week.from_now }
			end

			#if request.env["HTTP_USER_AGENT"] and !request.env["HTTP_USER_AGENT"].include?("facebookexternalhit/1.1")
				#redirect_to proc { url_for(params.except(:ref)) }  
			#end
		end
	end

end
