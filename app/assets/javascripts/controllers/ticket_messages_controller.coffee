class TicketMessagesController
  constructor: (@scope, @stateParams, @TicketMessage, @TicketMessagesService) ->
    window.messages_ctrl = @

    @ticket_id = @stateParams.id
    @service = new @TicketMessagesService @ticket_id
    @form_message = new @TicketMessage

    @loadMessages()

  loadMessages: ->
    @service.index (response) =>
      @setMessages response.messages

  setMessages: (messages_attributes) ->
    @messages = {}

    for message_attributes in messages_attributes
      message = new @TicketMessage message_attributes
      @messages[message.id] = message

    @updateAuxiliarDataStructures()

  updateAuxiliarDataStructures: ->
    @displayable_messages = ( message for id, message of @messages ).sort (m1, m2) =>
      if m1.created_at > m2.created_at
        1

      else if m1.created_at < m2.created_at
        - 1

      else
        0

  setBlankForm: ->
    @form_message = new @TicketMessage

  messageSaved: (response) ->
    message = new @TicketMessage response

    @messages[message.id] = message
    @updateAuxiliarDataStructures()
    @setBlankForm()

  save: ->
    if @form_message.isPersisted()
      @service.update @form_message, (response) =>
        @messageSaved response

    else
      @service.create @form_message, (response) =>
        @messageSaved response


TicketMessagesController.$inject = [ '$scope', '$stateParams', 'TicketMessage', 'TicketMessagesService' ]
angular.module('TicketsApp').controller 'TicketMessagesController', TicketMessagesController



# angular.module('MondeApp').controller 'TaskController', ($scope, $route, $routeParams, $location,
#                                                          TaskService, TaskMessageService, Task, TaskMessage) ->
#   window.ng_scope = $scope

#   $scope.editTask = ->
#     $scope.form_task = $scope.task

#   $scope.saveTask = ($event) =>
#     if $scope.form_task.isPersisted()
#       $scope.task_service.update $scope.form_task, saveTaskCallback

#     else
#       $scope.task_service.create $scope.form_task, saveTaskCallback

#   $scope.editTaskMessage = (task_message) ->
#     $scope.form_task_message = task_message

#   $scope.deleteTaskMessage = ($event, task_message) ->
#     text = "Confirm"

#     if $event
#       target = $($event.target).closest('[data-confirm]')
#       text = target.attr 'data-confirm' if target.length > 0

#     if confirm text
#       $scope.task_message_service.delete task_message, -> deleteTaskMessageCallback(task_message)

#   $scope.cancelEditTask = ->
#     clearFormTask()

#   $scope.cancelEditTaskMessage = ->
#     resetAddTaskMessageForm()

#   $scope.saveTaskMessage = ->
#     if $scope.form_task_message.isPersisted()
#       $scope.task_message_service.update $scope.form_task_message, saveTaskMessageCallback
#     else
#       $scope.task_message_service.create $scope.form_task_message, saveTaskMessageCallback

#     $scope.form_task = null

#   init = ->
#     $scope.task = null
#     $scope.task_id = $routeParams['id']

#     $scope.task_service = new TaskService serverErrorHandler
#     $scope.task_service.get $scope.task_id, setTask

#   setTask = (response) ->
#     $scope.task = new Task response
#     updatedDisplayableTaskMessages()
#     resetAddTaskMessageForm()
#     $scope.task_message_service = new TaskMessageService $scope.task, serverErrorHandler

#   updatedDisplayableTaskMessages = ->
#     $scope.displayable_task_messages = ( message for id, message of $scope.task.task_messages )

#   resetAddTaskMessageForm = ->
#     $scope.form_task_message = new TaskMessage

#   clearFormTask = ->
#     $scope.form_task = null

#   deleteTaskMessageCallback = (response) ->
#     $scope.task.removeTaskMessage response
#     updatedDisplayableTaskMessages()

#   saveTaskMessageCallback = (response) ->
#     if response.task_message['valid?']
#       $scope.task.saveMessage new TaskMessage response.task_message
#       updatedDisplayableTaskMessages()
#       resetAddTaskMessageForm()
#     else
#       showTaskMessageErrors response.task_message.errors

#   saveTaskCallback = (response) ->
#     if response['valid?']
#       $scope.task.setAttributes response, true
#       clearFormTask()
#     else
#       showTaskErrors response.errors

#   showTaskErrors = (errors) ->
#     $scope.form_task.errors = errors

#   showTaskMessageErrors = (errors) ->
#     $scope.form_task_message.errors = errors

#   serverErrorHandler = ->

#   init()
