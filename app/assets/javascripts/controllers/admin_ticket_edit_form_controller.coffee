class AdminTicketEditFormController
  constructor: (@scope, @state, @stateParams, @Ticket, @AdminTicketsService) ->
    window.ticket_form_ctrl = @
    @service = new @AdminTicketsService
    @loadTicket()

  loadTicket: ->
    @service.get @stateParams.id, @setTicket

  setTicket: (params) =>
    @ticket = new @Ticket params

  goBackToTicket: =>
    @state.go 'admin.admin_ticket', id: @ticket.id

  save: ->
    @service.update @ticket.id, @ticket.attributes(), @goBackToTicket

AdminTicketEditFormController.$inject = ['$scope', '$state', '$stateParams', 'Ticket', 'AdminTicketsService']
angular.module('TicketsApp').controller 'AdminTicketEditFormController', AdminTicketEditFormController
