(function() {
'use strict';

angular
  .module("groupmates.services")
    .factory("Upload", Upload);

  Upload.$inject = ['Files','$rootScope','$upload','$timeout','Project' ];

  function Upload(Files, $rootScope,$upload,$timeout,Project ) {
    
    $rootScope.progress = 0;
    var upload = null;

    return {
      upload : function ($files, sucessCallback, errorCallback) {
          if ($files == null){
            return;
          }
  //    for (var i = 0; i < $files.length; i++) {
          var parentId = $rootScope.breadcrumbs[$rootScope.breadcrumbs.length -1].id;
          var file = $files[0] ? $files[0] : $files; //files[i]
          $rootScope.uploadedFile = file;

          Files.exists(file.name, function(duplicate) {
            upload = $upload.upload({
              url: "/api/v1/projects/"+Project.id+"/assets" + (duplicate == null ? "" : "/" + duplicate) ,
              method: (duplicate == null ? 'POST' : 'PUT'),
              file: file,
              data: {user_id : Project.getUser(), parent_id : parentId},
              fileFormDataName: 'asset[uploaded]',
              formDataAppender: function(fd, key, val) {
                if (angular.isArray(val)) {
                  angular.forEach(val, function(v) {
                    fd.append('asset['+key+']', v);
                  });
                } else {
                  fd.append('asset['+key+']', val);
                }
              },
            })
            .progress(function(evt) {
              $rootScope.progress = parseInt(100.0 * evt.loaded / evt.total);
            })
            .success(function(data, status, headers, config) {
              if (sucessCallback != undefined){
                sucessCallback(data);              
              }
            })
            .error(function(err) {
              $rootScope.progress = 0;
              if (errorCallback != undefined){
               errorCallback(err);
              }
            });
          });
  //    }
      },
      abort : function(){
        upload.abort();
        upload = null;
        $rootScope.progress = 0;
      }
    };
  }


})();
