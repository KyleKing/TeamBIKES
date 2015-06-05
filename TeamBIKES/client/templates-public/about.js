// var isMobile = {
//     Android: function() {
//         return navigator.userAgent.match(/Android/i);
//     },
//     BlackBerry: function() {
//         return navigator.userAgent.match(/BlackBerry/i);
//     },
//     iOS: function() {
//         return navigator.userAgent.match(/iPhone|iPad|iPod/i);
//     },
//     Opera: function() {
//         return navigator.userAgent.match(/Opera Mini/i);
//     },
//     Windows: function() {
//         return navigator.userAgent.match(/IEMobile/i);
//     },
//     any: function() {
//         return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
//     }
// };


// Template.about.rendered = function () {
//   // var typedStrings = [" better"];

//   // jQuery(function($) {
//   //     if (!isMobile.any()) {
//   //       var typedStrings = [" better"];
//   //       $('#is-mobile').toggleClass('show hide');
//   //     }
//   //     if (isMobile.any()) {
//   //       var typedStrings = [" faster", " smarter", " cheaper", " better"];
//   //       $('#is-desktop').toggleClass('show hide');
//   //     }
//   // });

//   // such Wow.js animatinos for explanation section
//   new WOW().init();

//   // Typed.js demo -> outputs text for title
//   $(function(){
//       if (!isMobile.any()) {
//         // Is non-mobile device
//         var typedStrings = [" faster", " smarter", " cheaper", " better"];
//       }
//       if (isMobile.any()) {
//         // Is mobile device
//         var typedStrings = [" better"];
//       }
//       $(".typed-element").typed({
//         strings: typedStrings,
//         typeSpeed: 150,
//         // time before typing starts
//         startDelay: 300,
//         // time before backspacing
//         backDelay: 500,
//       });
//     });

//     /*!
//      * Start Bootstrap - Agency Bootstrap Theme (http://startbootstrap.com)
//      * Code licensed under the Apache License v2.0.
//      * For details, see http://www.apache.org/licenses/LICENSE-2.0.
//      */
//     // jQuery for page scrolling feature - requires jQuery Easing plugin
//     $(function() {
//         $('a.page-scroll').bind('click', function(event) {
//             var $anchor = $(this);
//             $('html, body').stop().animate({
//                 scrollTop: $($anchor.attr('href')).offset().top
//             }, 1500, 'easeInOutExpo');
//             event.preventDefault();
//         });
//     });
//     // // Highlight the top nav as scrolling occurs
//     // $('body').scrollspy({
//     //     target: '.navbar-fixed-top'
//     // });
//     // Closes the Responsive Menu on Menu Item Click
//     $('.navbar-collapse ul li a').click(function() {
//         $('.navbar-toggle:visible').click();
//     });
// };