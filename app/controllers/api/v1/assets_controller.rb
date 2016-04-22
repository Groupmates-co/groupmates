class Api::V1::AssetsController < Api::V1::BaseController

	after_action :verify_authorized, :except => [:index, :root, :exists]

	def show
		@asset = Asset.find(params[:id])
		@asset.revert_to(params[:version].to_i) if params[:version]
		authorize @asset
	end

	def index
		plural_resource_name = "@#{resource_name.pluralize}"
		resources = resource_class.where(query_params)

		@with_folders = params[:with_folders]
		if @with_folders
			@folders = Folder.where(query_params)
		end

		instance_variable_set(plural_resource_name, resources)
	end

	def versions
		asset = Asset.find(params[:id])

		authorize asset 
		@assets = Array.new

		asset.version.downto(1) do |version|
			asset = Asset.find(params[:id])
			asset.revert_to(version)
			@assets << asset
		end
		
		render 'index'
	end

	def root		
		@assets = Asset.where(query_params).where(parent_id: [0, nil])


		@with_folders = params[:with_folders]
		if @with_folders
			@folders = Folder.where(query_params).where(parent_id: nil)
		end
		render 'index'
	end

	def exists
		assets = Asset.where(project_id: params[:project_id]).where(uploaded_file_name: params[:name])
		render json: {duplicate: (assets.any? ? assets.first.id : nil )}, status: 200
	end

	def rename
 
		@asset = Asset.find(params[:assetId])
#		@asset.skip_version do
			new_file_name = 'uploads/projects/' + @asset.project.id.to_s + "/" +@asset.id.to_s + "/" + (@asset.version + 1).to_s + "/" + params[:name]

			authorize @asset

			file = @asset.uploaded.s3_object

	  		file.rename_to new_file_name, acl: @asset.uploaded.s3_permissions, content_type: @asset.uploaded.content_type
			@asset.update_attribute(:uploaded_file_name, params[:name])
			@asset.save
			render 'show'
#		end
	end

  private

    def asset_params
  		params.require(:asset).permit(:uploaded, :user_id, :project_id,:parent_id)
    end

	def query_params
		params.permit(:parent_id, :project_id, :version)
	end

end
