require 'rails_helper'

RSpec.describe 'Admin Tickets Report Requests', type: :request do
  let(:admin) { create_or_find_user :admin }
  let(:default_user) { create_or_find_user :user_ray }

  describe 'GET api/admin/tickets' do
    let(:tickets) {
      [create(:ticket), create(:ticket), create(:ticket), create(:ticket), create(:ticket)]
    }

    it 'is unauthorized user is not an admin' do
      login_as default_user
      get '/api/admin/reports/tickets', params: { tickets_ids: tickets.map(&:id) }
      expect(response).to be_unauthorized
    end

    it 'returns a PDF containing the selected reports' do
      login_as admin
      get '/api/admin/reports/tickets', params: { tickets_ids: tickets.map(&:id) }
      expect(response.headers["Content-Type"]).to eq 'application/pdf'
      expect(response.headers["Content-Disposition"]).to match(/attachment; filename=.*.pdf/)
    end
  end
end
