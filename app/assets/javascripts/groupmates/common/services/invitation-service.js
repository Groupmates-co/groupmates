(function() {
'use strict';

angular
	.module("groupmates.services")
		.factory("Invitations", Invitations)

	Invitations.$inject = ['$resource','$q', 'Project'];

	/**
	 * Message data
	 */
	function Invitations($resource, $q, Project) {

		var invitations = [];

		var invitationData = $resource('/api/v1/projects/:projectId/invitations/:invitationId',{projectId: Project.id, invitationId: '@invitationId'},{
			'update' : {
				method: 'PUT', isArray: false
			}
		});

		return {
			setData: function() {
				var deferred = $q.defer();
				invitationData.query({},function(data) {
					invitations = data;
					deferred.resolve(data);
				});
				return deferred.promise;
			},
			getData: function () {
				return invitations;
			},
			invite: function(email){
				if (email == "")
					return;

				var invit = {
					invited_by_id: Project.getUser(),
					project_id:  Project.id,
					status: (Project.isCreator())? 2 : 1,
					invited_email: email
				};

				invitationData.save(invit, function(data) {
					invitations.push(data);					
				});
			},
			approveMember: function(invit){
				var deferred = $q.defer();
				invit.status = (invit.status == 1)? 2 : 4;
				invitationData.update({"invitationId":invit.id}, invit, function (data) {
					_.find(invitations, function(el) {
						if (el.id == data.id) {
							el = data;
							return true;
						}
					});
					deferred.resolve(data);
				});
				return deferred.promise;
			},
			rejectMember: function(invit){
				invit.status = 5;
				invitationData.update({"invitationId":invit.id}, invit, function (data) {
					_.find(invitations, function(el) {
						if (el.id == data.id)
							el = data;
					});
				});
			}
		};
	}


})();
