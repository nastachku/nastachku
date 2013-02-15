jQuery ->

  $('input#user_company').autocomplete
    source: "/api/companies"
    minLength: 2

  $('input#user_city').autocomplete
    source: "/api/cities"
    minLength: 2

  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

