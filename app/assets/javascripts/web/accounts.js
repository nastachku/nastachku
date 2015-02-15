jQuery(document).ready(function ($) {

  $('.form_showpass').on('click',function() {
    var input = $('#user_old_password');
    if ($(this).hasClass('active')) {
      input.attr('type','password');
    } else {
      input.attr('type','text');
    }
    $(this).toggleClass('active');
  });

  $('.tabs__title').click(function(){
    $(this).siblings().removeClass('selected').end().next('dd').andSelf().addClass('selected');
  });

});
