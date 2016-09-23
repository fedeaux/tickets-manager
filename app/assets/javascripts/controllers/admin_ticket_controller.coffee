class AdminTicketController
  constructor: (@scope, @stateParams, @Ticket, @AdminTicketsService) ->
    window.ticket_ctrl = @
    @service = new @AdminTicketsService
    @loadTicket()

  loadTicket: ->
    @service.get @stateParams.id, @setTicket

  setTicket: (params) =>
    @ticket = new @Ticket params

AdminTicketController.$inject = ['$scope', '$stateParams', 'Ticket', 'AdminTicketsService']
angular.module('TicketsApp').controller 'AdminTicketController', AdminTicketController
