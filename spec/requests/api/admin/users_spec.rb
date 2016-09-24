require 'rails_helper'

RSpec.describe 'Admin Users Requests', type: :request do
  let(:admin) { create_or_find_user :admin }
  let(:another_admin) { create :admin, email: 'imnotamusician@admin.com' }

  describe 'PUT api/admin/users/:id' do
    let(:default_user) { create_or_find_user :user_ray }

    it 'is unauthorized if user is not an admin' do
      login_as default_user
      put "/api/admin/users/#{default_user.id}"
      expect(response).to be_unauthorized
    end

    context 'Admin' do
      before :each do
        login_as admin
      end

      it 'allows adding admin privileges' do
        put "/api/admin/users/#{default_user.id}", params: { user: { role: 'admin' }}
        json_response = JSON.parse response.body
        expect(json_response['isAdmin']).to be true
        default_user.reload

        expect(default_user.admin?).to be true
      end

      it 'allows revoking admin privileges' do
        put "/api/admin/users/#{another_admin.id}", params: { user: { role: 'customer' }}
        json_response = JSON.parse response.body
        expect(json_response['isAdmin']).to be false
        default_user.reload

        expect(default_user.admin?).to be false
      end

      it 'ignores role updates from the current user' do
        new_name = 'Stevie Ray Vaughn and the Double Trouble'

        put "/api/admin/users/#{admin.id}", params: { user: { role: 'customer', name: new_name }}
        json_response = JSON.parse response.body
        # expect(json_response['isAdmin']).to be true
        admin.reload

        expect(admin.name).to eq new_name
        expect(admin.admin?).to be true
      end
    end
  end
end
