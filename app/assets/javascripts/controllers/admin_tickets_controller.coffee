class AdminTicketsController
  constructor: (@scope, @stateParams, @Ticket, @AdminTicketsService) ->
    window.tickets_ctrl = @
    @service = new @AdminTicketsService
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

AdminTicketsController.$inject = [ '$scope', '$stateParams', 'Ticket', 'AdminTicketsService' ]
angular.module('TicketsApp').controller 'AdminTicketsController', AdminTicketsController
