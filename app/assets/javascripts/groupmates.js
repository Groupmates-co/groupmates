// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// JS Libraries
//= require pusher/dist/pusher
//= require underscore/underscore
//= require momentjs/moment
//= require foundation-datepicker/js/foundation-datepicker
//= require angularjs-file-upload/angular-file-upload-shim
//= require_self

// Angular
//= require angular/angular
//= require angular-resource/angular-resource
//= require angular-route/angular-route
//= require angular-img-fallback/angular.dcb-img-fallback.js
//= require angular-scroll-glue/src/scrollglue
//= require pusher-angular/lib/pusher-angular
//= require angular-foundation/mm-foundation.min
//= require ngDialog/js/ngDialog.js
//= require angularjs-file-upload/angular-file-upload
//= require angular-sanitize/angular-sanitize
//= require angular-animate/angular-animate.min
//= require angular-foundation/mm-foundation-tpls.min
//= require textAngular/dist/textAngular-rangy.min
//= require textAngular/dist/textAngular-sanitize.min
//= require textAngular/dist/textAngular.min
//= require jquery-timepicker-jt/jquery.timepicker.js
//= require angular-jquery-timepicker/src/timepickerdirective.js
//= require elasticui/dist/elasticui.min
//= require elastic.js/dist/elastic.min
//= require elasticsearch/elasticsearch.angular.min


// Angular App
//= require_tree ./groupmates/common
//= require_directory ./groupmates/messenger
//= require_directory ./groupmates/files
//= require_directory ./groupmates/calendar
//= require_directory ./groupmates/notes
//= require_directory ./groupmates/mates
//= require_directory ./groupmates/notifications
//= require_directory ./groupmates/settings
//= require ./groupmates/groupmates

// JQuery to load the very end, cos Angular templates need to be loaded
//= require ./groupmates/scripts.jquery

//var pusher = new Pusher('30714f2f23daf1d36e17');
//var messenger_channel = null;


