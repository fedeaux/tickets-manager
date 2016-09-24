angular.module('TicketsApp').factory 'ReportsService', ($resource, $http, $httpParamSerializer) ->
  class ReportsService
    constructor: ->
      @service = $resource('/api/admin/reports/:action', {}, {})

    tickets: (tickets_ids, complete) ->
      q = $httpParamSerializer "tickets_ids[]": tickets_ids
      window.location.href = "/api/admin/reports/tickets?#{q}"

    onServerResponse: (complete) ->
      (response) ->
        if complete
          complete response
