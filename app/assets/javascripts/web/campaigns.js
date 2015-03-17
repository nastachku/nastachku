function calculatePrices(ticketsCount, afterpartyTicketsCount, callback) {
  var params = {
    "tickets_count": ticketsCount,
    "afterparty_tickets_count": afterpartyTicketsCount
  }

  $.ajax({
    url: Routes.prices_api_order_path(),
    data: params,
    success: function(response) {
      callback(response.prices);
    }
  })
}
