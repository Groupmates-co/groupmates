class Api::V1::PusherController < Api::V1::BaseController

  after_action :verify_authorized, :except => :auth
  protect_from_forgery :except => :auth

  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id, # => required
        :user_info => { 
          :name => current_user.first_name+' '+current_user.last_name,
          :email => current_user.email,
          :profile_picture => current_user.profile_picture.url(:thumb)
        }
      })
      render :json => response
    else
      render :text => "Forbidden", :status => '403'
    end
  end

end