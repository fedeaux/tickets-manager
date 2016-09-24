class AdminTicketsController
  constructor: (@scope, @stateParams, @Ticket, @AdminTicketsService, @ReportsService) ->
    window.tickets_ctrl = @
    @service = new @AdminTicketsService
    @reports_service = new @ReportsService

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

  downloadAsPDF: ->
    @reports_service.tickets (ticket.id for ticket in @displayable_tickets), (response) =>
      console.log response

AdminTicketsController.$inject = [ '$scope', '$stateParams', 'Ticket', 'AdminTicketsService', 'ReportsService' ]
angular.module('TicketsApp').controller 'AdminTicketsController', AdminTicketsController
