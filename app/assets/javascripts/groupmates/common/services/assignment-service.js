(function() {
'use strict';

angular
  .module('groupmates.services')
  .factory('Assignment', Assignment);

  Assignment.$inject = ['$resource', 'Project'];

  function Assignment($resource, Project) {
    var resource = $resource('/api/v1/projects/:projectId/assignations', {projectId: Project.id}, {
      update: { 
        method: 'PUT',
        isArray: true 
      }
    });

    return {
      update: function(user) {
        return resource.update({'role': user.assignment});
      }
    }
  }
})();