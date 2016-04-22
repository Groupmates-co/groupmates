(function() {
  'use strict';

  angular
    .module('groupmates.services')
    .factory("PusherData", PusherData);

  PusherData.$inject = ['$rootScope', '$location', '$pusher', 'Project', 'Messages', 'Chats','Notifications','MsgViews'];

  function PusherData($rootScope, $location, $pusher, Project, Messages, Chats, Notifications, MsgViews) {

    var active_chat;
    var channel;
    var channelName;

    var pusher = $pusher(window.pusherClient);
    var presenceChannel = pusher.subscribe(Project.getPresenceChannel());
    var projectChannel = pusher.subscribe(Project.getChannel());

    this.presenceChannel = presenceChannel;

    presenceChannel.bind('client-new_user_in_chat', function(data) {
      Chats.userJoin(data.channel,data.user);
    });

    presenceChannel.bind('client-user_left_chat', function(data) {
      Chats.userLeave(data.channelId,data.userId);
    });

    presenceChannel.bind('client-chat_privacy_change', function(data) {
       Chats.pushChatPrivacy(data);
    });

    presenceChannel.bind('client-chat_name_change', function(data) {
      Chats.pushChatName(data);
    });

    projectChannel.bind('new_channel_open', function(data) {
      Chats.pushNewChannel(data);
    });

    projectChannel.bind('new_member_join', function(data) {
      Chats.userJoin(data.channel, data.user);
    });

    projectChannel.bind('new_member_leave', function(data) {
      Chats.userLeave(data.channel, data.user);
    });

    projectChannel.bind('member_read_message', function(data) {
      MsgViews.addNewView(data);
    });
    
    projectChannel.bind('new_message', function(data) {
      MsgViews.resetData(data.channel_id);
      if (Project.getUser() != data.user.id) {
        if (data.channel_id == active_chat){
          Messages.addData(data);         
        }
        if ($location.path().substr(1, 'messenger'.length) != 'messenger' || !window.isActive) {
          //or user is in different chat...
          //Play notification sound2
          document.getElementById("message_notification").play();
          //$rootScope.new_messages += 1;
          Chats.newUnreadMessage(data.channel_id);
            //_.countBy($rootScope.new_messages, function(el) {return el != 0;}).true);
          //Chats.pushUnseen(data);
          //$rootScope.new_message = data;
        }
      }
    });

    projectChannel.bind('updated_member', function(data) {
      Project.updateMember(data.user);
    });

    Chats.setData().then(function() {
      active_chat = Chats.getMainChannel().id;
      channelName = Chats.getChannelName(active_chat);
      channel = pusher.subscribe(channelName);

      bindEvents();
    });


    var bindEvents = function() {

      //Subscribe and add new messages coming on the WebSockets (thank you Pusher)
      channel.bind('new_member', function(data) {
        Project.addMember(data.user);
      });

      //Get read messages
      // channel.bind('client-messages_read', function(data) {
      //   console.log("Seen by");
      //   Chats.pushMessageRead(data);
      // });

      // Typing status
      channel.bind('client-start_typing', function(data) {
        if ($rootScope.typing.indexOf(data.id) == -1) {
          $rootScope.typing.push(data.id);
        }
      });
      channel.bind('client-stop_typing', function(data) {
        $rootScope.typing.splice($rootScope.typing.indexOf(data.id), 1);
      });

    };

    //Trigger seen notification
    var triggerSeen = function() {
      // channel.trigger('client-messages_read', {
      //   "user_id": Project.getUser(),
      //   "chat_id" : active_chat,
      //   "message_id" : Messages.getLastId(active_chat)
      // });
    };

    //
    $rootScope.$watch('messagesCount', function(newValue, oldValue) {
      if (newValue != oldValue) {
        Project.updateTitle();
        if (newValue == 0) {
          triggerSeen();
        }
      }
    });

    this.triggerNewUser = function(user, channel) {
      presenceChannel.trigger('client-new_user_in_chat', {
        "user": user,
        "channel": channel.id
      });
    }

    this.triggerUserLeave = function(userId, channel) {
      presenceChannel.trigger('client-user_left_chat', {
        "userId": userId,
        "channelId": channel.id
      });
    }

    this.triggerPolicyChange = function(chat) {
      presenceChannel.trigger('client-chat_privacy_change', chat);
    }

    this.triggerNameChange = function(chat) {
      presenceChannel.trigger('client-chat_name_change', chat);
    }

    this.triggerNewChat = function(chat) {
      presenceChannel.trigger('client-new_chat', chat);
    }

    this.startTyping = function() {
      channel.trigger('client-start_typing', {
        "id": Project.getUser()
      });
    };

    this.stopTyping = function() {
      channel.trigger('client-stop_typing', {
        "id": Project.getUser()
      });
    };

    this.getChannels = function() {
      return channels;
    }

    this.changeChannel = function(chat) {
      pusher.unsubscribe(channelName);

      active_chat = chat.id;
      channelName = Chats.getChannelName(chat.id);
      channel = pusher.subscribe(channelName);

      bindEvents();
    }

    // === DEBUG ====
    var debug = function() {
      console.group('Pusher - subscribed to:');
      for (var c in pusher.channels) {
        console.log(c);
      }
      console.groupEnd();
    }


    return this;
  }

})();