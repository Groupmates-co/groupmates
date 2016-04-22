(function() {
	'use strict';

	angular
		.module("groupmates.messenger.services", ['ngResource'])
		.factory("Messages", Messages)
		.factory("MsgViews", MsgViews)
		.factory("Favorites", Favorites);

	Messages.$inject = ['$resource', '$rootScope', 'Project', 'Chats'];
	MsgViews.$inject = ['$resource', '$rootScope', 'Project'];
	Favorites.$inject = ['$resource', '$http', 'Project'];

	/**
	 * Message data
	 */
	function Messages($resource, $rootScope, Project, Chats) {

		var _channelId;
		var messages = {};
		var errors = [];
		var page = 1;
		var hasNextPage = true;

		var resource = $resource('/api/v1/projects/:projectId/channels/:channelId/messages/:messageId', {
			projectId: Project.id,
			channelId: '@channelId',
			messageId: '@messageId',
			page: '@page'
		},{});

		return {
			setData: function(channelId) {
				var page = 1;
				var hasNextPage = true;
				_channelId = channelId;
				messages = resource.query({
					"channelId": channelId,
					"page": page
				});
			},
			getData: function() {
				return messages;
			},
			getMessagesByChannel: function(channelId) {
				messages = resource.query({'channelId': channelId});
				return messages;
			},
			addPage: function() {
				if (hasNextPage) {
					page++;
					resource.query({
						"channelId": _channelId,
						"page": page
					}, function(newMessages) {
						if (newMessages.length != 0) {
							for (var i = newMessages.length - 1; i >= 0; i--) {
								messages.unshift(newMessages[i]);
							}
						} else {
							hasNextPage = false;
						}
					});
				}
			},
			saveMessage: function(message) {
				resource.save({
					"channelId": _channelId,
					"message": message
				}, function(data) {
					// success
					messages.push(data);
					$rootScope.lastMessageIdSent = data.id;
				}, function(e) {
					// failure
					e.config.data.user = Project.getCurrentUser();
					e.config.data.hasErrors = true; //object
					e.config.data.errortext = "Error while saving"; //get real server error msg
					messages.push(e.config.data);
				});
			},
			addData: function(message) {
				message.created_at = Date.now();
				messages.push(message);
			},
			getLastId : function(channelId){
				for (var i = messages.length - 1; i >= 0; i--){
					if (messages[i].chat_id == channelId){
						return messages[i].id;
					}
				}
			},
		};
	}

	function MsgViews($resource, $rootScope, Project) {

		var resource = $resource('/api/v1/projects/:projectId/channels/:channelId/msg_views/:msgViewId', {
			projectId: Project.id,
			channelId: '@channelId',
			msgViewId: '@msgViewId'
		},{
				'view': {
					method: 'PATCH'
				},
			}
		);

		var msgViews = [];

		/** 
		 * Create a new MsgView
		 * Message_id is set on server side
		 */
		this.newMsgView = function(channelId) {
			var msgView = {
				channel_id: channelId,
				user_id: Project.getUser()
			}
			resource.view({'channelId': channelId, 'msgViewId': 'view', 'msg_view': msgView});
		};

		this.setData = function(channelId) {
			msgViews = resource.query({'channelId': channelId});
		};

		/** 
		 * Get MsgViews
		 */
		this.getData = function() {
			return msgViews;
		};

		/** 
		 * Reset MsgViews when new messages come in
		 */
		this.resetData = function(channelId) {
			msgViews = resource.query({'channelId': channelId});
		};

		this.addNewView = function(msgView) {
			var view = _.find(msgViews, function(el) {return el.id == msgView.id;});
			if (view) {
				_.find(msgViews, function(el) { 
					if(el.id == msgView.id && msgView.user_id == el.user_id) {
						el.updated_at = msgView.updated_at;
						el.message_id = msgView.message_id; return;
					}
				});
				//view = msgView;
			}
			else
				msgViews.push(msgView);
		};

		return this;
	}

	function Favorites($resource, $http, Project) {
		var base_url = '/api/v1/users/:userId/favorites/:favoriteId';
		return $resource(base_url, {
			userId: '@userId',
			project_id: Project.id
		}, {});
	}

})();