Template.agency.rendered = function () {
  console.log('test');
  $(function(){
      $(".element-three").typed({
        strings: [" faster", " smarter", " cheaper", " better"],
        typeSpeed: 150,
        // time before typing starts
        startDelay: 300,
        // time before backspacing
        backDelay: 500,
      });
  });
};