require 'rails_helper'

RSpec.describe 'Tickets Requests', type: :request do
  let(:current_user) { create_or_find_user :user_ray }

  describe 'GET api/tickets' do
    it 'is unauthorized if no user is logged in' do
      get '/api/tickets'
      expect(response).to be_unauthorized
    end

    context 'Authorized' do
      before :each do
        login_as current_user
        create :ticket
        create :ticket, title: 'Something is still going wrong'
        create :ticket, title: 'Something is going wrong but the current user doesn\'t care', user: create_or_find_user(:user_steve)
      end

      it 'returns a list of tickets for the current user' do
        get '/api/tickets'
        json_response = JSON.parse response.body
        expect(json_response['tickets'].count).to eq 2
        expect(json_response['tickets'].first.keys).to include 'id', 'title', 'created_at', 'status'
      end
    end
  end

  describe 'POST api/tickets' do
    it 'is unauthorized if no user is logged in' do
      post '/api/tickets'
      expect(response).to be_unauthorized
    end

    context 'Authorized' do
      before :each do
        login_as current_user
      end

      it 'creates and returns a ticket for the current user' do
        post '/api/tickets', params: { ticket: attributes_for(:ticket) }
        json_response = JSON.parse response.body
        expect(json_response).to have_key 'ticket'
        expect(current_user.tickets.first.title).to eq attributes_for(:ticket)[:title]
      end
    end
  end
end
