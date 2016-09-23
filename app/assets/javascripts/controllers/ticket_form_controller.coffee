class TicketFormController
  constructor: (@scope, @stateParams, @Ticket, @TicketsService) ->
    window.ticket_form_ctrl = @
    @ticket = new @Ticket
    @service = new @TicketsService
    @hasBeenCreated = false

  save: ->
    @service.create @ticket, @ticketCreated

  ticketCreated: (response) =>
    @hasBeenCreated = true

TicketFormController.$inject = ['$scope', '$stateParams', 'Ticket', 'TicketsService']
angular.module('TicketsApp').controller 'TicketFormController', TicketFormController
