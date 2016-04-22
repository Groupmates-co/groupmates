class ProjectFs

	@@projects_dir = "#{Rails.root}/public/uploads/projects/" 

	def self.create_project_folder(project)
  	dir = "#{@@projects_dir}/project-#{project.id}"
  	FileUtils.mkdir_p dir unless File.directory?(dir)
	end

	def self.create_folder(project, folder_name)
  	dir = "#{project_path(project)}/#{folder_name}"
  	FileUtils.mkdir_p dir unless File.directory?(dir)
	end

	def self.remove_folder(project, folder_name)
  	dir = "#{project_path(project)}/#{folder_name}"
		FileUtils.rm_rf dir if File.directory?(dir)
	end

	private
		def project_path(project)
			"#{@@projects_dir}/project-#{project.id}"
		end

end