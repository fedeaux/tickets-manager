@DateFormats =
  db_day: 'YYYY-MM-DD'
  pretty_day: 'ddd, MMM Do'

angular.module('TicketsApp', ['ngResource', 'ui.router'])

init = ->
  angular.bootstrap( $('#dashboard-wrapper'), ['TicketsApp'] )

$(document).on 'page:load', init
$(document).ready init
