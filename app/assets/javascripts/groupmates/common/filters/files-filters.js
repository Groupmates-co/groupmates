(function() {
'use strict';

angular
  .module('groupmates.filters')

  .filter('getFileTypeIcon', ['Project', function (Project) {
    return function (mime, param) {
      var types = [
        {
          "mime": "application/pdf",
          "icon": "fa-file-pdf-o",
          "type": "PDF"
        },
        {
          "mime": "image/png image/jpeg image/bmp",
          "icon": "fa-file-image-o",
          "type": "Image"
        },
        {
          "mime": "text/plain",
          "icon": "fa-file-text-o",
          "type": "Text"
        },
        {
          "mime": "application/octet-stream application/zip application/x-rar-compressed",
          "icon": "fa-file-zip-o",
          "type": "Archive"
        },
        {
          "mime": "application/msword application/vnd.openxmlformats-officedocument.wordprocessingml application/vnd.ms-word",
          "icon": "fa-file-word-o",
          "type": "Document"
        },
        {
          "mime": "application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml",
          "icon": "fa-file-excel-o",
          "type": "Spreadsheet"
        },
        {
          "mime": "application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.presentationml",
          "icon": "fa-file-powerpoint-o",
          "type": "Presentation"
        },
        {
          "mime": "audio/mp3 audio/mp4 audio/mpeg audio/ogg audio/wav",
          "icon": "fa-file-audio-o",
          "type": "Audio"
        },
        {
          "mime": "video/mp4 video/avi",
          "icon": "fa-file-video-o",
          "type": "Video"
        },
        {
          "mime": "folder",
          "icon": "fa-folder-open-o",
          "type": "Folder"
        }
      ];

//      var res = _.where(types, {mime: mime})[0];
      var res = _.filter(types, function(type) {
        var mimes = type.mime.split(" ");
        for (var i =0; i < mimes.length; i++){
          if (mime && mime.indexOf(mimes[i]) != -1){
            return type;
          }
        }
      })[0];

      if(param == "icon")
        return (res)? res.icon : "fa-file-o";
      else if (param == "type")
       return (res)? res.type : "Other";
      else
        return "";
    };
  }])

  .filter('getRelativeDate', function () {
    return function (date) {
      return moment(date).fromNow();
    };
  })

.filter('ordinalize', function () {
    return function (number) {
      var res = number.toString();
 
      if (/(11|12|13)/.test(Math.abs(number) % 100)) {
        res = number + 'th';
      } else {
        switch(number) {
        case 1:
          res = number + 'st';
          break;
        case 2:
          res = number + 'nd';
          break;
        case 3:
          res = number + 'rd';
          break;
        default:
          res = number + 'th';
        }
      }
 
      return res;
    };
  })

})();
