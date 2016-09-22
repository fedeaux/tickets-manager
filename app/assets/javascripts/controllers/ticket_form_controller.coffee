class TicketFormController
  constructor: (@scope, @stateParams) ->
    window.ticket_form_ctrl = @

TicketFormController.$inject = ['$scope', '$stateParams']
angular.module('TicketsApp').controller 'TicketFormController', TicketFormController
