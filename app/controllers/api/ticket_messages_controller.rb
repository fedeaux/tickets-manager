class Api::TicketMessagesController < Api::BaseController
  around_action :set_ticket

  def index
    @messages = @ticket.messages
  end

  def create
    @message = TicketMessage.create message_params.merge( ticket: @ticket, user: current_user )

    if @message.valid?
      render 'api/ticket_messages/show'
    else
      head 500
    end
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
    if @ticket.user.id == current_user.id or current_user.admin?
      yield
    else
      head 403
    end
  end

  def message_params
    params.require(:ticket_message).permit(:text, :read)
  end
end
