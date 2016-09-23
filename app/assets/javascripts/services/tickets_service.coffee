angular.module('TicketsApp').factory 'TicketsService', ($resource, $http) ->
  class TicketsService
    constructor: ->
      @service = $resource('/api/tickets/:id', {}, {})

    create: (ticket, complete) ->
      new @service(ticket: ticket.attributes()).$save @onServerResponse(complete), @errorHandler

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
