class Api::TicketsController < Api::BaseController
  def index
    @tickets = current_user.tickets
  end

  def create
    @ticket = Ticket.create ticket_params.merge( user: current_user )
    render :show
  end

  private
  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
