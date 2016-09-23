class TicketController
  constructor: (@scope, @stateParams, @Ticket, @TicketsService) ->
    window.ticket_ctrl = @
    @service = new @TicketsService
    @loadTicket()

  loadTicket: ->
    @service.get @stateParams.id, @setTicket

  setTicket: (params) =>
    @ticket = new @Ticket params

TicketController.$inject = ['$scope', '$stateParams', 'Ticket', 'TicketsService']
angular.module('TicketsApp').controller 'TicketController', TicketController
