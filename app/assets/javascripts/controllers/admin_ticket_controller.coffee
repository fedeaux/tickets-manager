class AdminTicketController
  constructor: (@scope, @stateParams, @Ticket, @AdminTicketsService) ->
    window.ticket_ctrl = @
    @service = new @AdminTicketsService
    @loadTicket()

  loadTicket: ->
    @service.get @stateParams.id, @setTicket

  setTicket: (params) =>
    @ticket = new @Ticket params

  closeThisTicket: =>
    if confirm('Only close this ticket if you are sure the problem is fixed. You will not be able to reopen it.')
      @service.update @ticket.id, { status: 'closed' }, @setTicket

AdminTicketController.$inject = ['$scope', '$stateParams', 'Ticket', 'AdminTicketsService']
angular.module('TicketsApp').controller 'AdminTicketController', AdminTicketController
