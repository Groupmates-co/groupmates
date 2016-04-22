class RegistrationsController < Devise::RegistrationsController

  layout "user", only: [:new, :edit, :create, :update]

  def new
    @invitation = nil
    if params[:invitation_token]
      cookies[:invitation_token] = params[:invitation_token]
      @invitation = Invitation.find_by(invitation_token: params[:invitation_token])
    end
    super
  end

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved

      if cookies[:invitation_token]
        # Remove the cookie from invitation
        cookies[:invitation_token] = nil
        cookies.delete :invitation_token#, :domain => '.groupmates.uk'
      end

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
      #Added: Save the gravatar when signup
      # if resource.gravatar_url
      #   resource.profile_picture = open(resource.gravatar_url)
      #   resource.save
      #   UserFs::save_user_picture(resource.gravatar_url)
      # end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params(resource))
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

	protected

		def after_sign_up_path_for(resource)
			url_for(controller: 'projects', action: 'index', only_path: true)
		end
 
	  def sign_up_params
	    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	  end

    def update_resource(resource, params)
      if resource.is_oauth
        resource.update_without_password(params)
      else
        super
      end
    end
	 
	  def account_update_params(resource)
      if resource.is_oauth
        params.require(:user).permit(:first_name, :last_name, :profile_picture, :email, :skype)
      else
        params.require(:user).permit(:first_name, :last_name, :profile_picture, :email, :skype, :password, :password_confirmation, :current_password)
      end
	  end

end