(function() {
'use strict';

var $defer, loaded = false;


angular

  .module("groupmates.notes.services",[])
    .factory("Notes", Notes);
    
  Notes.$inject = ['$resource', 'Project'];

  function Notes($resource, Project) {
    return $resource('/api/v1/projects/:projectId/notes/:noteId', {projectId: Project.id, noteId: "@noteId"},{
      update: { 
        method: 'PUT', 
        params: { noteId: '@noteId' }, 
        isArray: false 
      },
      shared: {
        method: 'GET',
        params: { noteId: 'shared' },
        isArray: true
      }
    });
  }

})();