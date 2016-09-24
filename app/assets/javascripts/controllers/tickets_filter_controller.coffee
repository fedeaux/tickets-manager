class TicketsFilterController
  constructor: (@scope) ->
    window.filter_ctrl = @

    @status_filter = 'all'
    @time_filter = 'all'
    @one_month_ago = moment().subtract(30, 'days')
    @scope.$emit 'TicketsFilter::Installed', filter: @filter

  setStatusFilter: (value) ->
    @status_filter = value
    @scope.$emit 'TicketsFilter::Updated'

  setTimeFilter: (value) ->
    @time_filter = value
    @scope.$emit 'TicketsFilter::Updated'

  filter: (ticket) =>
    ((@status_filter == 'all') or (ticket.status == @status_filter)) and
    ((@time_filter == 'all') or (ticket.created_at > @one_month_ago))

TicketsFilterController.$inject = [ '$scope' ]
angular.module('TicketsApp').controller 'TicketsFilterController', TicketsFilterController
