class Api::Admin::TicketsController < Api::Admin::BaseController
  def index
    @tickets = Ticket.all
    render '/api/tickets/index'
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])

    if @ticket
      render '/api/tickets/show'
    else
      head 404
    end
  end

  private
  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
