(function() {
'use strict';

angular
  
  .module('groupmates.services')

  // Global service containing for Interactive Help
  .factory("GroupmatesBot", ['$rootScope','$http', '$q', 'Project', 'Messages',
   function($rootScope, $http, $q, Project, Messages) {
      
    var invite = "";

    this.invite = function() {
      if(invite) {
        //Messages.addData(invite);
      }
      else {
      var deferred = $q.defer();
      $http({url: '/api/v1/projects/'+Project.id+'/invitation',method: 'GET'}).then(function(response) {
        invite = response.data
        Messages.addData(response.data);
        deferred.resolve(response.data);
      });
    }
    };

    return this;
  }]);

})();