(function() {
'use strict';

angular
  
  //Getter, because groupmates.services is created by members-services.js 
  // (alphabetical order of require_tree)
  .module('groupmates.services')

  // Global service containing user and project info
  .factory("Project", ['$rootScope', '$resource','$http', '$q',function($rootScope,$resource,$http,$q) {

    var id = document.getElementById('active-project').getAttribute("data-project-id");
    var userId = document.getElementById('active-project').getAttribute("data-user-id");
    this.id = id;
    var current_user = null;
    var project = {};

    var userData = $http.get('/api/v1/user');

    //Initiate $resource Object for Project (no custom methods)
    this.r = $resource('/api/v1/projects/:projectId', {projectId: id},{
      members: {
        method: 'GET',
        url: '/api/v1/projects/:projectId/users',
        isArray: true
      },
      update: {
        method: 'PUT',
        url: '/api/v1/projects/:projectId'
      }
    });

    //Initiate values when executed in the .run()
    this.setProject = function(){
      var deferred = $q.defer();
      this.r.get({}, function(data){
        project = data;
        deferred.resolve(data);
      });
      return deferred.promise;
    };

    this.setUser = function() {
      var deferred = $q.defer();
      userData.then(function(response) {
        current_user = response.data;
        deferred.resolve(response.data);
      });
      return deferred.promise;
    };

    this.updateTitle = function() {
      var unread = $rootScope.messagesCount;
      if (unread > 0){
        angular.element('title')[0].innerHTML = "("+unread+") " + this.getName();
      } else {
        angular.element('title')[0].innerHTML = this.getName();
      }
    };

    this.save = function(data) {
      var deferred = $q.defer();
      this.r.update({'project': data}, function() {
        deferred.resolve();
      });
      return deferred.promise;
    };

    this.getUser = function () {
      return userId;
    };

    this.getCurrentUser = function () {
      return current_user;
    };

    this.getChannel = function() {
      return "private-project-"+this.id;
    };

    this.getPresenceChannel = function() {
      return "presence-project-"+this.id;
    };

    this.getUsers = function(){
      return project.users;
    };

    this.getEndDate = function () {
      return moment(project.created_at).add(project.duration, 'days'); 
    };

    this.getUserById = function (userId) {
      return _.find(project.users, function(el) {return el.id == userId});
    };

    this.getName = function () {
      return project.name;
    };

    this.getProject = function () {
      return project;
    };

    this.saveLastVisit = function(){

    };

    this.addMember = function (member) {
      project.users.push(member);
    };

    this.isCreator = function () {
      return (project.creator ? project.creator.id === current_user.id : false);
    };

    this.updateMember = function (member) {
      _.each(project.users, function(user, i) {
        if (user.id == member.id) {
          project.users[i] = member;
        }
      });
    }

    return this;
  }]);

})();