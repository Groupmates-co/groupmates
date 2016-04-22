(function() {
	'use strict';

	angular
	.module("groupmates.files.services",[])
	.factory("Files", Files)
	.factory("Folders", Folders)
	.factory("FoldersData", FoldersData)

	Files.$inject = ['$resource', 'Project'];
	Folders.$inject = ['$rootScope','Project','FoldersData', 'Files'];
	FoldersData.$inject = ['$resource', 'Project'];
	
	function Files($resource, Project) {
		var base_url = '/api/v1/projects/:projectId/assets/:assetId';

		var files = {};
		var resource = $resource(base_url, {projectId: Project.id, assetId: "@assetId", folderId: '@folderId', version: "@version"},{
			download: {
				method: 'GET',
				url: '/api/v1/projects/:projectId/assets/:assetId/download',
				isArray: false
			},
			versions: {
				method: 'GET',
				url: '/api/v1/projects/:projectId/assets/versions/:id',
				params: {
					'id' : '@id'
				},
				isArray: true
			},
			exists: {
				method: "GET",
				url: '/api/v1/projects/:projectId/assets/exists',
				params: {
					'name' : '@name'
				}
			},
			queryFolder: {
				method: 'GET',
				url: '/api/v1/projects/:projectId/assets',
				params: {
					'with_folders': true,
					'parent_id': '@folderId'
				},
				isArray: true
			},
			rootFolder: {
				method: 'GET',
				url: '/api/v1/projects/:projectId/assets/root',
				params: {
					'with_folders': true,
				},
				isArray: true
			},
			rename: {
				method: 'PATCH',
				url: '/api/v1/projects/:projectId/assets/:assetId/rename',
				params: {
					'name' : '@name'
				}
			},
			update: {
				method: "PATCH"
			}
		});

	  files = resource.rootFolder(); //Root folder

	  return {
	  	get: function(id, version, callback) {
	  		resource.get({
	  			'assetId' : id,
	  			'version' : version},
	  			function(data){
	  				callback(data);
	  			});
	  	},
	  	getVersions: function(file, callback){
	  		resource.versions({'id' : file.id}, function(data){
	  			callback(data);
	  		});
	  	},
	  	getData: function () {
	  		return files;
	  	},
	  	pushAsset: function (asset){
	  		files.push(asset);
	  	},
	  	rejectAsset: function (asset){
			files = _.reject(files,function(el) { 
				return (el.id === asset.id && el.uploaded_content_type == asset.uploaded_content_type); //check if asset is actually asset or file?
			});
	  	},
	  	getFilesFolder: function(folderId) {
	  		if (folderId) {
	  			files = resource.queryFolder({'parent_id': folderId});
	  		} else {
	  			files = resource.rootFolder();
	  		}
	  		return true;
	  	},
	  	deleteFile: function(file){
	  		if(null != file.id) {
	  			resource.delete({'assetId': file.id});
	  			this.rejectAsset(file);
	  		}
	  	},
	  	rename: function(file, callback){
	  		resource.rename({'assetId': file.id, 'name':file.name},function(data){
	  			if (callback != null)
	  				callback(data);
	  		});
	  	},
	  	update: function(file){
	  		resource.update({'assetId': file.id, 'asset':file},function(data){
	  		});	
	  	},
	  	exists: function(name, callback){
	  		resource.exists({'name' : name}, function(data){
	  			callback(data.duplicate);
	  		});
	  	}
	  }
	}

	function Folders($rootScope, Project, FoldersData, Files) {

		return {
			newFolder: function () {
				var parentId = $rootScope.breadcrumbs[$rootScope.breadcrumbs.length -1].id;
				var folder = {
					"name": "untitled folder",
					"project_id": Project.id,
					"parent_id" : (parentId == 0 ? null : parentId),
					"user_id": Project.getUser(),
					"uploaded_file_size": null,
					"uploaded_content_type": "folder",
					"url": null,
					"created_at": new Date()
				};
				FoldersData.save({"folder": folder}, function (data){
					Files.pushAsset(data);
				});
				return folder;
			},
			deleteFolder: function (file) {
				FoldersData.delete({'folderId' : file.id});
				Files.rejectAsset(file);
			}
		}
	}

	function FoldersData($resource, Project) {
		var base_url = '/api/v1/projects/:projectId/folders/:folderId';
		return $resource(base_url, {projectId: Project.id, folderId: "@folderId"},{
			update: {
				method: "PATCH"
			}
		});
	}

})();