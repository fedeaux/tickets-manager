tickets =
  url: ''
  views:
    'dashboard@':
      templateUrl: '/templates/tickets/index'
      controller: 'TicketsController as tickets_ctrl'

tickets_with_slash = angular.copy tickets
tickets_with_slash.url = '/'

angular.module('TicketsApp')
.config ($stateProvider) ->
  $stateProvider.state('app',
    abstract: true
    template: '<ui-view/>'

  ).state('app.tickets', tickets)

  .state('app.stickets', tickets_with_slash)

  .state('app.new_ticket',
    url: '/tickets/new'
    views:
      'dashboard@':
        templateUrl: '/templates/tickets/open'
        controller: 'TicketFormController as ticket_form_ctrl'

  ).state('app.ticket',
    url: '/tickets/:id'
    views:
      'dashboard@':
        templateUrl: '/templates/tickets/show'
        controller: 'TicketController as ticket_ctrl'

  ).state('admin',
    url: '/admin'
    abstract: true
    template: '<ui-view/>'

  ).state('admin.admin_tickets',
    url: '/tickets'
    views:
      'dashboard@':
        templateUrl: '/templates/admin/tickets/index'
        controller: 'AdminTicketsController as tickets_ctrl'

  ).state('admin.admin_ticket',
    url: '/tickets/:id'
    views:
      'dashboard@':
        templateUrl: '/templates/admin/tickets/show'
        controller: 'AdminTicketController as ticket_ctrl'

  ).state('admin.edit_ticket',
    url: '/tickets/:id/edit'
    views:
      'dashboard@':
        templateUrl: '/templates/admin/tickets/edit'
        controller: 'AdminTicketEditFormController as ticket_form_ctrl'

  ).state('admin.users',
    url: '/users'
    views:
      'dashboard@':
        templateUrl: '/templates/admin/users/index'
        controller: 'AdminUsersController as users_ctrl'
  )
