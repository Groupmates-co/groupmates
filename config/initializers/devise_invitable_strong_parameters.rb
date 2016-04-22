
#Devise::InvitationsController.class_eval do
#  def update_resource_params
#    params.require(resource_name).permit(
#      :invitation,
#      :password,
#      :password_confirmation
#    )
#  end
#end