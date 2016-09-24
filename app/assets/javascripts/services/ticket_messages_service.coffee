angular.module('TicketsApp').factory 'TicketMessagesService', ($resource, $http) ->
  class TicketMessagesService
    constructor: (@ticket_id) ->
      @service = $resource('/api/tickets/:ticket_id/messages/:id', { ticket_id: @ticket_id }, {})

    create: (message, complete) ->
      new @service(ticket_message: message.attributes()).$save @onServerResponse(complete), @errorHandler

    index: (complete) ->
      new @service().$get @onServerResponse(complete), @errorHandler

    get: (id, complete) ->
      new @service().$get {id: id}, @onServerResponse(complete), @errorHandler

    errorHandler: ->
      alert 'Something went wrong, try again later'

    onServerResponse: (complete) ->
      (response) ->
        if complete
          complete response
