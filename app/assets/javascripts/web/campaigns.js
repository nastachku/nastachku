function calculateDiscount(ticketsCount, afterpartyTicketsCount, totalPrice, changeTotal) {
  var params = {
    "tickets_count": ticketsCount,
    "afterparty_tickets_count": afterpartyTicketsCount
  }

  $.ajax({
    url: Routes.api_campaigns_discount_path(),
    data: params,
    success: function(response) {
      var discountAmount = response["discount_amount"];
      changeTotal(discountAmount);
    }
  })
}
