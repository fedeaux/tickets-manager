class Api::Admin::ReportsController < Api::Admin::BaseController
  def tickets
    @tickets = Ticket.find(params[:tickets_ids])
    pdf = WickedPdf.new.pdf_from_string(render_to_string 'admin/reports/tickets' )
    send_data pdf, type: "application/pdf", filename: 'tickets.pdf'
  end
end
