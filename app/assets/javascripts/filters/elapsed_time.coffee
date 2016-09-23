angular.module('TicketsApp').filter 'elapsed_time', ($filter) ->
  (date) ->
    number_of_days = moment().diff date, 'days'

    if number_of_days == 0
      return 'Today'

    if number_of_days == 1
      return "Yesterday"

    if number_of_days < 7
      return "#{number_of_days} days ago"

    if number_of_days < 30
      weeks = Math.round(number_of_days/7)
      return 'Last week' if weeks == 1
      return "#{weeks} weeks ago"

    else
      months = Math.round(number_of_days/30)
      return 'Last month' if months == 1
      return "#{months} months ago"
