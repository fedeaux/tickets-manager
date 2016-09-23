class TicketsController
  constructor: (@scope, @stateParams, @Ticket, @TicketsService) ->
    window.tickets_ctrl = @
    @service = new @TicketsService
    @loadTickets()

  loadTickets: ->
    @service.index (response) =>
      @setTickets response.tickets

  setTickets: (tickets_attributes) ->
    @tickets = {}

    for ticket_attributes in tickets_attributes
      ticket = new @Ticket ticket_attributes
      @tickets[ticket.id] = ticket

    @updateAuxiliarDataStructures()

  updateAuxiliarDataStructures: ->
    @displayable_tickets = ( ticket for id, ticket of @tickets ).sort (t1, t2) =>
      if t1.created_at > t2.created_at
        (-1)

      else if t1.created_at < t2.created_at
        1

      else
        0

TicketsController.$inject = [ '$scope', '$stateParams', 'Ticket', 'TicketsService' ]
angular.module('TicketsApp').controller 'TicketsController', TicketsController
