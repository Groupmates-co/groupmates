(function() {
'use strict';

angular

	.module('groupmates.calendar.services',[])
	.factory("Events", Events);

	Events.$inject = ['$resource','Project','config'];

	function Events($resource, Project, config) {
		return $resource('/api/v1/projects/:projectId/events/:eventId',{projectId: Project.id, eventId: '@eventId'},{
			update: { 
				method: 'PUT', 
				params: { eventId: '@eventId' }, 
				isArray: false 
			} 
		});
	}

})();