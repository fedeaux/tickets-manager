class Api::TicketsController < Api::BaseController
  def index
    @tickets = current_user.tickets
  end
end
