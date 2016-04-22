(function() {
	'use strict';

	angular

		.module('groupmates.services.chat', [])
		.factory("Chats", Chats);

	Chats.$inject = ['$resource', '$q', 'Project', 'User', 'MsgViews'];

	function Chats($resource, $q, Project, User, MsgViews) {
		var chats;

		var seen;

		var resource = $resource('/api/v1/projects/:projectId/channels/:channelId', {
			projectId: Project.id,
			channelId: '@channelId'
		}, {
			'update': {
				method: 'PATCH'
			},
			'getSeen': {
				url: "/api/v1/projects/:projectId/channels/:channelId/msg_views/",
				method: "GET",
				params: {
					projectId: Project.id,
					channelId: '@channelId'
				},
				isArray: true
			},
			'updateSeen': {
				url: "/api/v1/projects/:projectId/channels/:channelId/msg_views/:id",
				method: "PATCH",
				params: {
					projectId: Project.id,
					channelId: '@channelId',
					id: '@id'
				},
			},
			'addSeen': {
				url: "/api/v1/projects/:projectId/channels/:channelId/msg_views/",
				method: "POST",
				params: {
					projectId: Project.id,
					channelId: '@channelId'
				}
			}
		});
	
		/**
		 * Init data of the Service
		 */
		var setData = function() {
			var deferred = $q.defer();
			resource.query({}, function(data) {
				chats = data;
				deferred.resolve(data);
			});
			return deferred.promise;
		};

		/**
		 * Create a channel
		 * Return object newly created
		 */
		var saveChannel = function(channel) {
			var deferred = $q.defer();
			resource.save({"channel": channel}, function(newChannel) {
		 			deferred.resolve(newChannel);
			});
			return deferred.promise;
		}

		/**
		 * Update a channel information
		 * @return Object channel
		 */
		var update = function(channel) {
			var deferred = $q.defer();
			channel.user_ids = []; //Convert users objects into ids
			for(var i=0; i < channel.users.length; i++) {
				channel.user_ids.push(channel.users[i].id);
			}
			resource.update({'channelId':channel.id,'channel':channel}, function(data) {
				deferred.resolve(data);
				_.find(chats, function(chan) { 
					if(channel.id == chan.id) {
						chan = channel; return;
					}
				});
			});
			return deferred.promise;
		};

		/**
		 * Delete a channel
		 * @return null
		 */
		var destroy = function(channel) {
			resource.remove({'channelId':channel.id});
			chats = _.reject(chats,function(el) { 
				return el.id === channel.id;
			});
		};

		/* --------------------------------------------------*\
		 *		 								SETTERS 
		\* --------------------------------------------------*/

		/**
		 * Init data of the Service
		 * Expects array of objects
		 */
		this.setData = function() {
			return setData();
		}

		/**
		 * Init a channel object with default values
		 * Expects a channel object.
		 */
		this.initNewChannel = function(name){
			return {
				name: name,
				is_private: false,
				user_ids: [Project.getUser()],
				is_main: false,
				is_one_to_one: false
			}
		}

		/**
		 * Adds a new channel.
		 * Expects a channel object.
		 */
		this.pushNewChannel = function(channel) {
			chats.push(channel);
		}


		/* --------------------------------------------------*\
		 *		 								GETTERS 
		\* --------------------------------------------------*/

		// Get array of channels
		this.getData = function() {
			return chats;
		}

		// Get Pusher's channel name of a channel
		this.getChannelName = function(channelId) {
			return "private-project-" + Project.id + "-channel-" + channelId;
		}

		// et the main channels for project
		this.getMainChannel = function() {
			return _.find(chats, function(el){ return el.is_main; });
		}

		// Get 1to1 channel according to a user (recipient)
		this.getPrivateChannelByUser = function (recipient) {
			return _.find(chats, function(el){ 
				var chan = _.find(el.users, function(user){ return user.id == recipient.id });
				return chan && el.is_one_to_one;
			});
		}

		// Get the recipient in the context of a private chat
		this.getPrivateChannelRecipient = function (channel) {
			return _.find(channel.users, function(el){ 
				return el.id != Project.getUser();
			});
		}

		/* --------------------------------------------------*\
		 *		 				DATA MANIPULATION METHODS
		\* --------------------------------------------------*/

		// Create a channel
		this.newChannel = function(channelName) {
			var newChan = this.initNewChannel(channelName);
			return saveChannel(newChan);
		}

		// Create a 1to1 conversation with user
		this.newPrivateChannel = function(user) {
			var channel = {
				name: user.fullname,
				is_one_to_one: true,
				is_private: true,
				user_ids: [Project.getUser()]
			};
			channel.user_ids.push(user.id);
			return saveChannel(channel);
		}

		// Update a channel (@see var update)
		this.update = update;

		// Add the member to channel
		this.join = function(channel) {
			channel.users.push(Project.getCurrentUser());
			return update(channel);
		};

		// Remove a member from a channel
		this.leave = function(chan) {
			if(chan.users.length > 1) {
				var channel = _.find(chats, function(el){ 
					if(el.id == chan.id) {
						el.users = _.reject(el.users,function(user) { return user.id == Project.getUser();});
						return true;
					}
				});
				update(channel);
			}
			else
				destroy(chan);
		};

		// Add a member to channel (from Pusher)
		this.userJoin = function(channelId, member) {
			_.find(chats, function(el){ if(el.id == channelId) {
				// Find if the member exists, don't add it
				if (!_.find(el.users, function(user){ return user.id == member.id })) {
					el.users.push(member);
					return true;
				}	
			}});
		};

		// Remove a member to channel (from Pusher)
		this.userLeave = function(channelId, memberId) {
			_.find(chats, function(el){ 
				if(el.id == channelId) {
					el.users = _.reject(el.users,function(user) { return user.id == memberId});
					return true;
				}
			});
			chats = _.reject(chats, function(el) {
				return el.users.length == 0;
			});
		};

		/* --------------------------------------------------*\
		 *		 				UNREAD MESSAGES NOTIFICATIONS
		\* --------------------------------------------------*/

		/**
		 * Get the number of unread messages (sum) of all channels
		 * @return int unread
		 */
    this.getUnreadMessages = function() {
      return _.countBy(chats, function(el) {return el.unread > 0;}).true;
    };

    /**
     * Increment unread messages number for a given channel
     */
    this.newUnreadMessage = function(channelId){
    	var channel = _.find(chats, function (el) { return (el.id == channelId); });
    	if (channel) {
	    	var userInChat = _.find(channel.users, function (el) {return el.id == Project.getUser() });
	    	if (userInChat) {
				channel.unread = (channel.unread > 0) ? parseInt(channel.unread) + 1 : 1;
				return;
	    	}
    	}
    };

    /**
     * Reset unread messages number for a given channel
     */
    this.readMessages = function(channelId) {
    	var decrement = false;

      _.find(chats, function(el){ 
      	if(el.id == channelId){
      		decrement = (el.unread > 0)? true : false;
      		el.unread = 0;
      		return;
      	}
     	});

      if(decrement)
      	MsgViews.newMsgView(channelId);
    };


		// var newMsgView = function(chatId,) {
		// 	var deferred = $q.defer();
		// 	resource.getSeen({
		// 		"channelId": chatId
		// 	}, function(data) {
		// 		seen = data;
		// 		console.log(seen);
		// 		deferred.resolve(data);
		// 	});
		// 	return deferred.promise;
		// }

		// this.addSeen = function(chatId, messageId) {
		// 	console.log(chatId + ", " + messageId);
		// 	var msg_view = {};
		// 	msg_view.user_id = Project.getUser();
		// 	msg_view.chat_id = chatId;
		// 	msg_view.message_id = messageId;

		// 	var id = 0;
		// 	console.log(seen);
		// 	for (var i = 0; i < seen.length; i++) {
		// 		if (seen[i].user_id == Project.getUser() && seen[i].chat_id == chatId) {
		// 			id = seen[i].id;
		// 		}
		// 	}

		// 	var deferred = $q.defer();
		// 	if (id == 0) {
		// 		resource.addSeen({
		// 			"channelId": chatId,
		// 			'msg_view': msg_view
		// 		}, function(data) {
		// 			seen.push(data);
		// 			console.log(seen);
		// 			deferred.resolve(data);
		// 		})
		// 	} else {
		// 		resource.updateSeen({
		// 			"channelId": chatId,
		// 			'id': id,
		// 			'msg_view': msg_view
		// 		}, function(data) {
		// 			console.log("ADDING SEEN");
		// 			console.log(data);
		// 			for (var i = 0; i < seen.length; i++) {
		// 				if (seen[i].id == data.id && seen[i].chat_id == data.chat_id) {
		// 					console.log("CHANGING" + seen[i].message_id + " >> " + data.message_id);
		// 					seen[i].message_id = data.message_id;
		// 				}
		// 			}
		// 			console.log(seen);
		// 			//setData();
		// 			deferred.resolve(data);
		// 		});

		// 	}
		// 	return deferred.promise;
		// }

		// this.getSeen = function() {
		// 	return seen;
		// }

		// this.setSeen = function(chatId) {
		// 	return setSeen(chatId);
		// }

		// // Events from Pusher

		// /**
		//  * Adds a new User to a chat.
		//  * Expects an object with 'chat' and 'user' attributes.
		//  */
		// this.pushUser = function(chatUser) {
		// 	console.log('new user from pusher');
		// 	//_.find(chats, function(el){ if(el.id == chatUser.chat.id) {el.users.push(chatUser.user); return;}});
		// 	for (var i = 0; i < chats.length; i++) {
		// 		if (chats[i].id == chatUser.chat.id) {
		// 			chats[i].users.push(chatUser.user);
		// 		}
		// 	}
		// }



		/**
		 * Changes the privacy of a chat.
		 * Expects a chat object.
		 */
		this.pushChatPrivacy = function(chat) {
			_.find(chats, function(el) {
				if( el.id == chat.id){
					el.is_private = chat.is_private;
					return;
				}
			});

		}
		
		/**
		 * Changes the name of a chat.
		 * Expects a chat object.
		 */
		this.pushChatName = function(channel) {
			_.find(chats, function (el) {
				if (el.id == channel.id)
					el.name = channel.name;
			});
		}


		// /**
		//  * Adds a mesage to unseen.
		//  * Expects a message object.
		//  */
		// this.pushUnseen = function(message){
		// 	for (var i = 0; i < chats.length; i++) {
		// 		if (chats[i].id == message.chat_id) {
		// 			if (chats[i].unseen == undefined) {
		// 				chats[i].unseen = 0;
		// 			}
		// 			chats[i].unseen += 1;
		// 		}
		// 	}
		// }

		// /**
		//  * Makes a message seen by a user.
		//  * Expects a MsgView object.
		//  */
		// this.pushMessageRead = function(msgView){
		// 	console.log('getting message read from pusher');
		// 	console.log(msgView);
		// 	for (var i = 0; i < seen.length; i++){
		// 		console.log(seen[i]);
		// 		if (seen[i].user_id == msgView.user_id && seen[i].chat_id == msgView.chat_id){
		// 			seen[i].message_id = msgView.message_id;
		// 			return;
		// 		}
		// 	}
		// 	seen.push(msgView);
		// 	return;
		// }

		return this;
	}

})();