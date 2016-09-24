angular.module('TicketsApp').factory 'Ticket', ($resource) ->
  class Ticket
    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes, skip_associations = false) ->
      for name, default_value of @defaultAttributes skip_associations
        if attributes.hasOwnProperty(name) and attributes[name] != null
          @[name] = attributes[name]
        else
          @[name] = default_value

      @parseDateFields()
      @addAuxiliarAttributes()

    isPersisted: ->
      !! @id

    parseDateFields: ->
      @created_at = moment @created_at
      @closed_at = moment @closed_at

    defaultAttributes: (skip_associations = false) ->
      attr =
        id: null
        title: null
        description: null
        status: null
        created_at: null
        closed_at: null

      attr

    addAuxiliarAttributes: ->
      @is_open = (@status == 'open')
      @is_closed = (@status == 'closed')

    attributes: ->
      attr = {}

      for name, default_value of @defaultAttributes true
        attr[name] = @[name]

      attr
