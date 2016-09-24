class AdminUsersController
  constructor: (@scope, @User, @AdminUsersService) ->
    window.users_ctrl = @
    @service = new @AdminUsersService

    @loadUsers()

  loadUsers: ->
    @service.index (response) =>
      @setUsers response.users

  setUsers: (users_attributes) ->
    @users = {}

    for user_attributes in users_attributes
      user = new @User user_attributes
      @users[user.id] = user

    @updateAuxiliarDataStructures()

  promoteToAdmin: (user) =>
    if confirm('This user will be able to view and close every ticket on
                the system and to promote other users to the admin status. Do you want to proceed?')

      @service.update user.id, { role: 'admin' }, @userUpdated

  removeAdminPrivileges: (user) =>
    if confirm('This user will no longer be able to view tickets that he/she hasn\'t created. Do you want to proceed?')
      @service.update user.id, { role: 'customer' }, @userUpdated

  userUpdated: (params) =>
    @users[params['id']] = new @User params
    @updateAuxiliarDataStructures()

  updateAuxiliarDataStructures: =>
    @displayable_admins = []
    @displayable_customers = []

    for id, user of @users
      if user.isAdmin
        @displayable_admins.push user

      else
        @displayable_customers.push user

AdminUsersController.$inject = [ '$scope', 'User', 'AdminUsersService' ]
angular.module('TicketsApp').controller 'AdminUsersController', AdminUsersController
