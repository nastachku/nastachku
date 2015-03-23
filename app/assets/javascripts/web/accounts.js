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
    if (input.files && input.files[0] && (input.files[0].type == 'image/png' || input.files[0].type == 'image/jpeg')) {
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


  $('.ticket').change(function() {
    ticketChanged();
  });
});

function ticketChanged() {
  var ticketCount = $('#ticket').is(':checked') ? 1 : 0;
  var afterpartyCount = $('#afterparty').is(':checked') ? 1 : 0;

  calculatePrices(ticketCount, afterpartyCount, function(prices) {
    if(prices.campaign && prices.campaign_discount_value > 0) {
      $("#campaign_discount").show();
      $("#campaign_name").html("“" + prices.campaign.name + "”:")
      $("#campaign_discount_value").html(prices.campaign_discount_value);
    } else {
      $("#campaign_discount").hide();
    }
    if(prices.coupon && prices.coupon_discount_value > 0) {
      $("#coupon_discount").show();
      $("#coupon_discount_value").html(prices.coupon_discount_value);
    } else {
      $("#coupon_discount").hide();
    }
    $('#total-price').html(prices.cost);
  });
}

