require 'rails_helper'

feature "Create a new ticket", js: true do
  let(:current_user) {
    create_or_find_user :user_ray
  }

  before :each do
    sign_in_with(current_user.email, attributes_for(:user_ray)[:password] )
    visit '/#/tickets/new'
  end

  context "Valid input data" do
    let(:title) { 'Can you please help me with that?' }

    it 'creates a new ticket' do
      fill_in 'ticket[title]', with: title
      fill_in 'ticket[description]', with: 'bug ' * 14
      find('#open-ticket-button').click
      expect(page).to have_content 'Thank you for you feedback'
    end
  end
end
