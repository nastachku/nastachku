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

  $('#false_photo_input').click(function(){
    $("#user_photo").click();
    return false;
  });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
          $('#user_photo_preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#user_photo").change(function() {
    readURL(this);
  })
});
