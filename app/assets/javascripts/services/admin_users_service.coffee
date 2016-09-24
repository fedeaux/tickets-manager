angular.module('TicketsApp').factory 'AdminUsersService', ($resource, $http) ->
  class AdminUsersService
    constructor: ->
      @service = $resource('/api/admin/users/:id', {}, {
       'update': { method: 'PUT'}
      })

    index: (complete) ->
      new @service().$get @onServerResponse(complete), @errorHandler

    update: (id, attributes, complete) ->
      new @service( user: attributes ).$update {id: id}, @onServerResponse(complete), @errorHandler

    errorHandler: ->
      alert 'Something went wrong, try again later'

    onServerResponse: (complete) ->
      (response) ->
        if complete
          complete response
