class Api::Admin::TicketsController < Api::Admin::BaseController
  before_action :set_ticket, only: [:show, :update]

  def index
    @tickets = Ticket.all
    render '/api/tickets/index'
  end

  def show
    if @ticket
      render '/api/tickets/show'
    else
      head 404
    end
  end

  def update
    if @ticket
      if @ticket.open?
        @ticket.update ticket_params
        @ticket.reload
        render '/api/tickets/show'
      else
        head 422
      end
    else
      head 404
    end
  end

  private
  def set_ticket
    @ticket = Ticket.find params[:id]
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status)
  end
end
