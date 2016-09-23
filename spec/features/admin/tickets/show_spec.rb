require 'rails_helper'

feature "View a ticket", js: true do
  let(:current_user) { create_or_find_user :admin }
  let(:open_ticket) { create :ticket }
  let(:closed_ticket) { create :ticket, :closed }

  before :each do
    sign_in_with(current_user.email, attributes_for(:admin)[:password] )
  end

  it 'displays the open ticket info and a button to close it' do
    visit "#/admin/tickets/#{open_ticket.id}"
    expect(page).to have_content open_ticket.title
    expect(page).to have_content open_ticket.description

    expect(page).to have_css '#close-ticket-button'
    expect(page).to have_css '#edit-ticket-button'
    expect(page).not_to have_css '#closed-ticket-message'
  end

  it 'displays the closed ticket info and a message that it has already been closed' do
    visit "#/admin/tickets/#{closed_ticket.id}"
    expect(page).to have_content open_ticket.title
    expect(page).to have_content open_ticket.description

    expect(page).not_to have_css '#close-ticket-button'
    expect(page).not_to have_css '#edit-ticket-button'
    expect(page).to have_css '#closed-ticket-message'
  end
end
