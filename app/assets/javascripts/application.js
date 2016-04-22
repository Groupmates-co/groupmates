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
//= require jquery
//= require turbolinks
//= require foundation
//= require emojione/lib/js/emojione.min
//= require application/cookie_consent.js
//= require_self

//Close Alerts message after 4 seconds
window.setTimeout(function() {
    $(".alert-box").fadeTo(250, 0).slideUp(250, function(){
        $(this).remove();
    });
}, 6000);

// Go to anchor links with nice animation
$(function() {
  // $('a[href*=#]:not([href=#])').click(function() {
  //   if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
  //     var target = $(this.hash);
  //     target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
  //     if (target.length) {
  //       $('html,body').animate({
  //         scrollTop: target.offset().top
  //       }, 1000);
  //       return false;
  //     }
  //   }
  // });
});

//Init Foundation Framework

$(document).on('ready page:load', function () {
  $(function(){ $(document).foundation(); });
});


//Cookie consent
$('document').ready( function () {
    cc.initialise({
      cookies: {
        social: {},
        analytics: {}
      },
      settings: {
        consenttype: "implicit",
        bannerPosition: "bottom",
        hideprivacysettingstab: true
      },
      strings: {
        notificationTitleImplicit: "We use cookies to improve your online experience. ",
        seeDetailsImplicit:  "  If you select to 'Continue' without changing your browser settings, you are giving your consent to receive cookies.",
        allowCookiesImplicit: "Continue"
      }
    });
});
