/* Slider */

$(function() {
  var slider = $('#da-slider');

  if (slider.size() > 0) {
    slider.cslider({
      autoplay  : true,
      interval : 9000
    });
  }
      
});