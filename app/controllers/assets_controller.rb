class AssetsController < ApplicationController

  def download
  	@asset = Asset.find(params[:id])
  	path = "#{Rails.public_path}/uploads/projects/#{@asset.project_id}/#{@asset.uploaded_file_name}"
		send_file(path, :disposition => 'inline', :type => @asset.uploaded_content_type, :x_sendfile => true )
  end

  private
    def asset_params
      params.require(:asset).permit(:uploaded, :user_id, :project_id)
    end
end