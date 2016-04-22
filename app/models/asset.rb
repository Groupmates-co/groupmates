class Asset < ActiveRecord::Base

	belongs_to :project
	belongs_to :user
	belongs_to :parent, class_name: "Folder", foreign_key: "parent_id"

	has_and_belongs_to_many :messages

  	#has_attached_file :file, {:styles => {:large => "320x320>", :medium => "280x280>", :thumb => "70x55#", :tiny => "36x36#" }}

	versioned :if => :version_asset

 	has_attached_file :uploaded,
 		:keep_old_files => true,
		:url => "/uploads/projects/:project_id/:id/:version/:basename.:extension",
    :path => ":rails_root/public/uploads/projects/:project_id/:id/:version/:basename.:extension",
  	:convert_options => { :all => '-strip -trim' }

  validates_attachment_presence :uploaded
	validates_attachment_size :uploaded, :less_than => 50.megabytes, :message => "The file must be smaller than 50 megabytes."
	validates_attachment_content_type :uploaded,
		:content_type => /\A(?:image|application|audio|text|video)\/.*\Z/ , :message => "The file's contents did not match its extension."

	Paperclip.interpolates :version do |attachment, style|
    		attachment.instance.version.to_s
  	end

	Paperclip.interpolates :id do |attachment, style|
    		attachment.instance.id.to_s
  	end

	def file_name
		uploaded_file_name
	end

	def html_link
		self.uploaded.url
	end

	def version_asset
		(!self.parent_id_changed?)
	end

end
