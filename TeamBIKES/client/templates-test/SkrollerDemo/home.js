Template.home.rendered = function () {
  /**
   * This demo was prepared for you by Petr Tichy - Ihatetomatoes.net
   * Want to see more similar demos and tutorials?
   * Help by spreading the word about Ihatetomatoes blog.
   * Facebook - https://www.facebook.com/ihatetomatoesblog
   * Twitter - https://twitter.com/ihatetomatoes
   * Google+ - https://plus.google.com/u/0/109859280204979591787/about
   * Article URL: http://ihatetomatoes.net/simple-parallax-scrolling-tutorial/
   */

  ( function( $ ) {

    // Setup variables
    $window = $(window);
    $slide = $('.homeSlide');
    $body = $('body');

    adjustWindow();
    $body.addClass('loaded');

    function adjustWindow() {
      // Init Skrollr
      var s = skrollr.init();
      // Get window size
      winH = $window.height();
      // Keep minimum height 550
      if(winH <= 550) {
        winH = 550;
      }
      // Resize our slides
      $slide.height(winH);
      // Refresh Skrollr after resizing our sections
      s.refresh($('.homeSlide'));
    }

  } )( jQuery );
};