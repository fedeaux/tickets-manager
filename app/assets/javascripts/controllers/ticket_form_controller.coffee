class TicketFormController
  constructor: (@scope, @stateParams, @Ticket, @TicketsService) ->
    window.ticket_form_ctrl = @
    @ticket = new @Ticket
    @service = new @TicketsService

  save: (form) ->
    if form.$valid
      @service.create @ticket, @ticketCreated

  ticketCreated: (response) =>
    @ticket_id = response.id

TicketFormController.$inject = ['$scope', '$stateParams', 'Ticket', 'TicketsService']
angular.module('TicketsApp').controller 'TicketFormController', TicketFormController
