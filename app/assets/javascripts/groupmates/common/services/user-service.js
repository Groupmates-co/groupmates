(function() {
'use strict';

angular
  .module("groupmates.services")
    .factory("User", User)

  User.$inject = ['$resource', '$rootScope', 'Project', '$q'];

  function User($resource, $rootScope, Project, $q) {
 
    var user = null;
    var resource = $resource('/api/v1/users/:userId',{userId: '@userId'},{
      'update' : {
        method: 'PATCH', isArray: false
      }
    });

    return {

      initData: function (userId) {
          var deferred = $q.defer();
          user = resource.get({'userId': userId}, function(data){
            deferred.resolve(data);
          });
          return deferred.promise;
      },
      getUser: function() {
        return user;
      },
      update: function(user) {
        return resource.update({'user': user, 'userId': user.id});
      }
    };
  }


})();
