angular.module('TicketsApp').factory 'AdminTicketsService', ($resource, $http) ->
  class AdminTicketsService
    constructor: ->
      @service = $resource('/api/admin/tickets/:id', {}, {
       'update': { method: 'PUT'}
      })

    create: (ticket, complete) ->
      new @service(ticket: ticket.attributes()).$save @onServerResponse(complete), @errorHandler

    index: (complete) ->
      new @service().$get @onServerResponse(complete), @errorHandler

    get: (id, complete) ->
      new @service().$get {id: id}, @onServerResponse(complete), @errorHandler

    update: (id, attributes, complete) ->
      new @service( ticket: attributes ).$update {id: id}, @onServerResponse(complete), @errorHandler

    errorHandler: ->
      alert 'Something went wrong, try again later'

    onServerResponse: (complete) ->
      (response) ->
        if complete
          complete response
