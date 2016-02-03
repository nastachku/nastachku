//= require jquery
//= require jquery.timeTo.min
//= require js-routes
//= require ./web/alerts
//= require ./web/campaigns
//= require ./web/fancySelect
jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
  });
});


$(document).ready(function(){
  // $('#flipTimer').timeTo({
  //     timeTo: new Date(2015, 1, 28, 23, 59),
  //     displayDays: 2,
  //     theme: "black",
  //     displayCaptions: true,
  //     fontSize: 44,
  //     captionSize: 14,
  //     lang: 'ru'
  // });
  SliderColleagues();
  //ticketsCountChanged();

  $('input[name="radioFace"]').change(function(){
    if($('input[name="radioFace"]:checked').val() == 'forFizicFace')
    {
      $('.forYuricFace').hide();
      $('.forFizicFace').show();
    }
    else{
      if($('input[name="radioFace"]:checked').val() == 'forYuricFace')
      {
        $('.forFizicFace').hide();
        $('.forYuricFace').show();
      }
    }
  }).change();
});
function SliderColleagues(){
    var $nextControl = $('.slider_colleagues .controls.next');
    var $previewControl = $('.slider_colleagues .controls.preview');
    var $sliderBox = $('.slider_colleagues .slider_big_box');
    var $elements = $sliderBox.find('.item');
    var elementCount = $elements.length;
    var index = 0;

    $nextControl.click(nextSlide);
    $previewControl.click(previewSlide);

    function nextSlide(){
        index ++;
        if(index >= elementCount - 3) {
            index = 0;
        }
        $sliderBox.animate({
            marginLeft: '-' + index * 202 + 'px'
        }, 300);
    }
    function previewSlide(){
        index--;
        if(index == -1)
            index = elementCount-4;
        $sliderBox.animate({
            marginLeft: '-' + index * 202 + 'px'
        }, 300);
    }
}

function ticketsCountChanged() {
  var tickets = $("#order_tickets").val();
  var afterpartyTickets = $("#order_afterparty_tickets").val();

  calculatePrices(tickets, afterpartyTickets, function(prices) {
    var price = $('#ticketPrice');
    price.html($('#order_tickets').val() * price.data('price'));

    var price = $('#afterpartyPrice');
    price.html($('#order_afterparty_tickets').val() * price.data("price"));

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

function changeTicketPrice() {
  ticketsCountChanged();
}

function changeAfterpartyPrice() {
  ticketsCountChanged();
}

$(document).ready(function(){
  $('.promo .popup .close_window, .promo .overlay').click(function (){
    $('.promo .popup, .promo .overlay').css('opacity','0');
    $('.promo popup, .promo .overlay').css('visibility','hidden');
  });
});

function lal(id)
  {
    $('#'+id).css('opacity','1');
    $('.promo .overlay').css('opacity','1');
    $('#'+id).css('visibility','visible');
    $('.promo .overlay').css('visibility','visible');
  }
