require 'rails_helper'

RSpec.describe 'Ticket Messages Requests', type: :request do
  let(:current_user) { create_or_find_user :user_ray }
  let(:another_user) { create_or_find_user :user_steve }
  let(:admin) { create_or_find_user :admin }

  describe 'GET api/tickets/:ticket_id/messages' do
    let(:ticket) { create :ticket, :with_messages, user: current_user }

    it 'returns a list of messages for the given ticket' do
      login_as current_user
      get "/api/tickets/#{ticket.id}/messages"
      json_response = JSON.parse response.body

      expect(json_response).to have_key 'messages'
      expect(json_response['messages'].count).to eq 3
    end

    it 'forbids an user trying to get the messages for a ticket that is not his/hers' do
      login_as another_user
      get "/api/tickets/#{ticket.id}/messages"
      expect(response.status).to eq 403
    end

    it 'admins can get messages from any ticket' do
      login_as admin
      get "/api/tickets/#{ticket.id}/messages"
      expect(response.status).to eq 200
    end
  end

  describe 'POST api/tickets/:ticket_id/messages' do
    let(:ticket) { create :ticket, :with_messages, user: current_user }

    it 'creates a message a returns it' do
      login_as current_user
      message_text = 'Oh, nevermind, I have figured it out myself'
      post "/api/tickets/#{ticket.id}/messages", params: { ticket_message: { text: message_text } }
      json_response = JSON.parse response.body
      expect(json_response['text']).to eq message_text
    end

    it 'forbids an user trying to get the messages for a ticket that is not his/hers' do
      login_as another_user
      message_text = 'Oh, nevermind, I have figured it out myself'
      post "/api/tickets/#{ticket.id}/messages", params: { ticket_message: { text: message_text } }
      expect(response.status).to eq 403
    end

    it 'admins can get messages from any ticket' do
      login_as admin
      message_text = 'Oh, nevermind, I have figured it out myself'
      post "/api/tickets/#{ticket.id}/messages", params: { ticket_message: { text: message_text } }
      expect(response.status).to eq 200
    end
  end
end
