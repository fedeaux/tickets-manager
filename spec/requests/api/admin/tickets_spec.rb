require 'rails_helper'

RSpec.describe 'Admin Tickets Requests', type: :request do
  let(:admin) { create_or_find_user :admin }

  describe 'GET api/admin/tickets' do
    let(:default_user) { create_or_find_user :user_ray }
    let(:another_user) { create_or_find_user :user_steve }

    it 'is unauthorized user is not an admin' do
      login_as default_user
      get '/api/admin/tickets'
      expect(response).to be_unauthorized
    end

    context 'Admin' do
      before :each do
        create :ticket
        create :ticket, title: 'Something is still going wrong'
        create :ticket, title: 'Something is going wrong but the current user doesn\'t care', user: create_or_find_user(:user_steve)
        login_as admin
      end

      it 'returns a list of all tickets' do
        get '/api/admin/tickets'
        json_response = JSON.parse response.body
        expect(json_response['tickets'].count).to eq 3
      end
    end
  end

  describe 'GET api/admin/tickets/:id' do
    let(:ticket) { create :ticket }

    it 'returns the ticket data' do
      login_as admin
      get "/api/admin/tickets/#{ticket.id}"
      json_response = JSON.parse response.body
      expect(json_response['title']).to eq ticket.title
    end
  end

  describe 'PUT api/admin/tickets/:id' do
    let(:open_ticket) { create :ticket }
    let(:closed_ticket) { create :ticket, :closed }

    it 'updates the ticket and returns the ticket updated data' do
      login_as admin
      previous_title = open_ticket.title
      new_title = "#{previous_title} [Solved]"

      put "/api/admin/tickets/#{open_ticket.id}", params: { ticket: { title: new_title } }
      json_response = JSON.parse response.body
      expect(json_response['title']).to eq new_title
      expect(Ticket.find(open_ticket.id).title).to eq new_title
    end

    it 'updates the ticket closed_at if updating ticket status' do
      login_as admin

      put "/api/admin/tickets/#{open_ticket.id}", params: { ticket: { status: 'closed' } }
      json_response = JSON.parse response.body

      expect(json_response['status']).to eq 'closed'
      expect(json_response).to have_key 'closed_at'

      expect(Ticket.find(open_ticket.id).closed_at).not_to be_nil
    end

    it 'denies updates (unprocessable entity) if the ticket has been closed already' do
      login_as admin
      previous_title = closed_ticket.title
      new_title = "#{previous_title} [Solved]"

      put "/api/admin/tickets/#{closed_ticket.id}", params: { ticket: { title: new_title } }
      expect(response.status).to eq 422
      expect(Ticket.find(closed_ticket.id).title).to eq previous_title
    end
  end
end
