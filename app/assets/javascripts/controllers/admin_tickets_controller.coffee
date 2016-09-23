class AdminTicketsController
  constructor: (@scope, @stateParams, @Ticket, @AdminTicketsService) ->
    window.tickets_ctrl = @
    @service = new @AdminTicketsService

    @scope.$on 'TicketsFilter::Installed', @setFilter
    @scope.$on 'TicketsFilter::Updated', @updateAuxiliarDataStructures

    @loadTickets()

  showTicket: (ticket) =>
    if @filter
      @filter ticket
    else
      true

  setFilter: (event, args) =>
    @filter = args.filter

  loadTickets: ->
    @service.index (response) =>
      @setTickets response.tickets

  setTickets: (tickets_attributes) ->
    @tickets = {}

    for ticket_attributes in tickets_attributes
      ticket = new @Ticket ticket_attributes
      @tickets[ticket.id] = ticket

    @updateAuxiliarDataStructures()

  updateAuxiliarDataStructures: =>
    @displayable_tickets = ( ticket for id, ticket of @tickets when @showTicket(ticket) ).sort (t1, t2) =>
      if t1.created_at > t2.created_at
        (-1)

      else if t1.created_at < t2.created_at
        1

      else
        0

AdminTicketsController.$inject = [ '$scope', '$stateParams', 'Ticket', 'AdminTicketsService' ]
angular.module('TicketsApp').controller 'AdminTicketsController', AdminTicketsController
