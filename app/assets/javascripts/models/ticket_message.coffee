angular.module('TicketsApp').factory 'TicketMessage', ($resource) ->
  class TicketMessage
    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes, skip_associations = false) ->
      for name, default_value of @defaultAttributes skip_associations
        if attributes.hasOwnProperty(name) and attributes[name] != null
          @[name] = attributes[name]
        else
          @[name] = default_value

      @parseDateFields()

    isPersisted: ->
      !! @id

    parseDateFields: ->
      @created_at = moment @created_at

    defaultAttributes: (skip_associations = false) ->
      attr =
        id: null
        user: null
        text: null
        created_at: null
        read: false

      unless skip_associations
        attr.user = {}

      attr

    attributes: ->
      attr = {}

      for name, default_value of @defaultAttributes true
        attr[name] = @[name]

      attr
