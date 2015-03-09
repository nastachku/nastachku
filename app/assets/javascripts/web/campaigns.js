function calculateDiscount(ticketsCount, afterpartyTicketsCount, totalPrice, changeTotal) {
  var params = {
    "tickets_count": ticketsCount,
    "afterparty_tickets_count": afterpartyTicketsCount
  }

  $.ajax({
    url: Routes.api_campaigns_discount_path(),
    data: params,
    success: function(response) {
      var discountPercentage = response["discount_percentage"];
      var total = calculatePriceWithDiscount(totalPrice, discountPercentage);
      changeTotal(total)
    }
  })
}

function calculatePriceWithDiscount(totalPrice, discountPercentage) {
  var total = totalPrice * ((100 - discountPercentage) / 100);
  return total;
}
