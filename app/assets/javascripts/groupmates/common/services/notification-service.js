(function() {
'use strict';

angular
  
  //Getter, because groupmates.services is created by members-services.js 
  // (alphabetical order of require_tree)
  .module('groupmates.services')

  // Global service containing user and project info
  .factory("Notifications",Notifications);

  Notifications.$inject = ['$rootScope','$resource','Project','Chats'];

  function Notifications ($rootScope, $resource, Project, Chats) {

    return {
      getUnreadMessages: function() {
        return Chats.getUnreadMessages();
      }
    }
  }

})();