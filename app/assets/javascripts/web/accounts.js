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

  fixMarkup();

  $('.ticket').change(function() {
    ticketChanged();
  });
});

function ticketChanged() {
  var ticketCount = $('#ticket').is(':checked') ? 1 : 0;
  var afterpartyCount = $('#afterparty').is(':checked') ? 1 : 0;

  calculatePrices(ticketCount, afterpartyCount, function(prices) {
    if(prices.campaign) {
      $("#campaign_discount").show();
      $("#campaign_discount_value").html(prices.campaign_discount_value);
    } else {
      $("#campaign_discount").hide();
    }
    if(prices.coupon) {
      $("#coupon_discount").show();
      $("#coupon_discount_value").html(prices.coupon_discount_value);
    } else {
      $("#coupon_discount").hide();
    }
    $('#total-price').html(prices.cost);

    fixMarkup();
  });
}

function fixMarkup() {
  if($(".order__new__items").length > 0) {
    var newMargin = $(".order__new__items").height() + 180;
    $(".personal__identity__social").css('marginTop', newMargin + "px");
  }
}
