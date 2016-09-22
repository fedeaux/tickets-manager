class TicketsController
  constructor: (@scope, @stateParams) ->
    window.tickets_ctrl = @
    @loadTickets()

  loadTickets: ->
    @tickets = {
      1: {
        title: 'Angular not working',
        created_at: moment(),
        status: 'open',
        unread_messages: 2,
        is_open: true
      },

      2: {
        title: 'Rails not working',
        created_at: moment().subtract(10, 'days'),
        status: 'closed'
        unread_messages: 0,
        is_closed: true
      },
    }

    @updateAuxiliarDataStructures()

  updateAuxiliarDataStructures: ->
    @displayable_tickets = ( ticket for id, ticket of @tickets )

TicketsController.$inject = ['$scope', '$stateParams']
angular.module('TicketsApp').controller 'TicketsController', TicketsController
