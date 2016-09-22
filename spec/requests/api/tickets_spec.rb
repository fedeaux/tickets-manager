require 'rails_helper'

RSpec.describe 'Tickets Requests', type: :request do
  describe 'GET api/tickets' do
    it 'is unauthorized if no user is logged in' do
      get '/api/tickets'
      expect(response).to be_unauthorized
    end

    context 'Authorized' do
      before :each do
        login_as create_or_find_user :user_ray
        create :ticket
        create :ticket, title: 'Something is still going wrong'
        create :ticket, title: 'Something is going wrong but the current user doesn\'t care', user: create_or_find_user(:user_steve)
      end

      it 'returns a hierarchy tree of tickets for the current user' do
        get '/api/tickets'
        json_response = JSON.parse response.body
        ap json_response
        expect(json_response['tickets'].count).to eq 2
        expect(json_response['tickets'].first.keys).to include 'id', 'title', 'created_at', 'status'
      end
    end
  end
end
