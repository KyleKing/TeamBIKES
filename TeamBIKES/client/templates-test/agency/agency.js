Template.agency.rendered = function () {
  console.log('test');
  $(function(){
      $(".element-three").typed({
        strings: [" faster", " smarter", " cheaper", " better"],
        typeSpeed: 20
      });
  });
};