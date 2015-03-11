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

  ticketChanged();

  $('.ticket').change(function() {
    ticketChanged();
  });
});

function ticketChanged() {
  var ticketCount = $('#ticket').is(':checked') ? 1 : 0;
  var afterpartyCount = $('#afterparty').is(':checked') ? 1 : 0;

  var ticketPrice = parseInt($('#ticket-price').text()) || 0;
  var afterpartyPrice = parseInt($('#afterparty-price').text()) || 0;
  var total = ticketPrice * ticketCount + afterpartyPrice * afterpartyCount;

  calculateDiscount(ticketCount, afterpartyCount, total, function(priceWithDiscount) {
    $('#total-price').html(priceWithDiscount);
    if (priceWithDiscount < total) {
      $('#without-discount').html(total);
    } else {
      $('#without-discount').html('');
    }
  });
}
