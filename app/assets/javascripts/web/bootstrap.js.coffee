jQuery ->

  $('input#user_company').autocomplete
    source: Routes.api_companies_path()
    minLength: 2

  $('input#user_city, input#q_city_cont').autocomplete
    source: Routes.api_cities_path()
    minLength: 2

  $(".vote-tooltip").tooltip
    trigger: 'click'
    placement: 'bottom'