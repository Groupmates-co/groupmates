(function() {
'use strict';

angular
  
  //Getter, because groupmates.services is created by members-services.js 
  // (alphabetical order of require_tree)
  .module('groupmates.services')

  // Global service containing user and project info
  .factory("Preferences",Preferences);

  Preferences.$inject = ['$rootScope','$resource', '$q', 'Project','Chats'];

  function Preferences ($rootScope, $resource, $q, Project, Chats) {

    var preferences = {};

    var resource = $resource("/api/v1/users/:userId/preferences/:preferenceId", {
      userId : Project.getUser(), 
      preferenceId: "@preferenceId", 
      project_id: Project.id },{
        update: {
          method: "PATCH"
        }
      });

    return {
      setPreferences: function(){
        var deferred = $q.defer();
        resource.query({},function(data){
          preferences = data[0];
          deferred.resolve(data[0]);
        });
        return deferred.promise;
      },
      save: function(preferences){
        var deferred = $q.defer();
        resource.save({'preference' : preferences}, function(data) {
          deferred.resolve(data);
        });
        return deferred.promise;
      },
      update: function(preferences){
        var deferred = $q.defer();
        resource.update({'preferenceId' : preferences.id, 'preference' : preferences}, function(data){
          deferred.resolve(data);
        });
        return deferred.promise;
      },
      getData: function() {
        return preferences;
      }
    }
  }

})();