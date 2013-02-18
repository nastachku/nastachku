jQuery ->

  $('input#user_company').autocomplete
    source: Routes.api_companies_path()
    minLength: 2

  $('input#user_city').autocomplete
    source: Routes.api_cities_path()
    minLength: 2

#  $("a[rel=popover]").popover()
#  $(".tooltip").tooltip()
#  $("a[rel=tooltip]").tooltip()

