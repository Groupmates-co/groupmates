(function() {
'use strict';

angular
  .module('groupmates.filters')

  .filter('getUserName', ['Project', function (Project) {
    return function (id, full) {
      var user = Project.getUserById(id);
      if (user['first_name'] === null)
        return user['email'];
      else
        return (!full)? user['first_name'] :
          user['first_name']+" "+user['last_name'];
    };
  }])

  .filter('getChatDate', [ '$filter', function ($filter) {
    return function (dateTime) {
      var date = moment(dateTime);
      return (date.diff(moment(),'days') >= -1)?
        ((date.diff(moment(),'days')==0)? "Today" : "Yesterday") :
        date.format('dddd DD MMMM YYYY');
    }
  }])

  .filter('getPictureUrl', ['Project','config', function (Project, config) {
    return function (item) {
      var user = Project.getUserById(item);
      return (user)? user.profile_picture : config.user_placeholder;
    };
  }])

  .filter('fallback', function(){
    return function(item) {
      return "https://s3-eu-west-1.amazonaws.com/groupmates/user_placeholder.png"
    }
  })

  .filter('getInvitationStatus', [ 'Project', function (Project) {
    return function (item) {
      switch (item) {
        case 1:
          return "Invited"
          break;
        case 2:
          return "Invited"
          break;
        case 3:
          return "Pending"
          break;
        case 4:
          return "Completed"
          break;
        case 5:
          return "Rejected"
          break;
        default:
          return "Unknown"
      }
    };
  }])

})();
