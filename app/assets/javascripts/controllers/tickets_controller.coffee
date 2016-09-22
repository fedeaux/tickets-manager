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
    @displayable_tickets = ( ticket for id, ticket of @tickets )

TicketsController.$inject = [ '$scope', '$stateParams', 'Ticket', 'TicketsService' ]
angular.module('TicketsApp').controller 'TicketsController', TicketsController
