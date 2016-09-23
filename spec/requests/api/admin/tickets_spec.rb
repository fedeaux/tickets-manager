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
end
